import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:services_catalog/detail_dialog.dart';
import 'package:services_catalog/di.dart';
import 'package:services_catalog/entities/provider_model.dart';
import 'package:services_catalog/stream_marker_plugin.dart';
import 'package:services_catalog/utils/geo_converters.dart';
import 'package:services_catalog/widgets/circular_marker.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map-screen';

  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  // it seems like this must be stateful in order mapController to work
  final TextEditingController _searchFieldController = TextEditingController();
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    // _mapController must be created in initState
    _mapController = MapController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final _latTween = Tween<double>(
      begin: _mapController.center.latitude,
      end: destLocation.latitude,
    );
    final _lngTween = Tween<double>(
      begin: _mapController.center.longitude,
      end: destLocation.longitude,
    );
    final _zoomTween = Tween<double>(
      begin: _mapController.zoom,
      end: destZoom,
    );

    var controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    Animation<double> animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    controller.addListener(
      () {
        _mapController.move(
          LatLng(
            _latTween.evaluate(animation),
            _lngTween.evaluate(animation),
          ),
          _zoomTween.evaluate(animation),
        );
      },
    );

    animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          controller.dispose();
        } else if (status == AnimationStatus.dismissed) {
          controller.dispose();
        }
      },
    );

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final di = Provider.of<DI>(context, listen: false);

    di.providerModelCollection.limit(10).get().then(
      (snapshot) {
        var geopoints = snapshot.docs
            .map(
              (doc) => toLatLng(doc.data().geopoint),
            )
            .toList();

        var centerZoom = _mapController.centerZoomFitBounds(
          LatLngBounds.fromPoints(geopoints),
          options: const FitBoundsOptions(
            padding: EdgeInsets.all(100),
          ),
        );

        _animatedMapMove(centerZoom.center, centerZoom.zoom);
      }
    );

    return Scaffold(
      appBar: AppBar(),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          zoom: 13.0,
          plugins: [StreamMarkerPlugin()],
          maxZoom: 18.0,
          center: LatLng(49.195061, 16.606836),
          onTap: (_, __) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            attributionBuilder: (_) {
              return const Text("© OpenStreetMap contributors");
            },
          ),
          StreamMarkerLayerOptions<ProviderModel>(
            stream: di.searchBloc.state,
            markerCreator: <ProviderModel>(document) {
              return CircularMarker(
                point: toLatLng(document.geopoint),
                label: (document.serviceType as String)
                    .characters
                    .first
                    .toUpperCase(),
                onTap: () {
                  var x = _mapController.centerZoomFitBounds(
                    LatLngBounds.fromPoints([toLatLng(document.geopoint)]),
                    // options: FitBoundsOptions(
                    //   maxZoom: _mapController.zoom,
                    //   padding: const EdgeInsets.only(top: 10),
                    // ),
                  );
                  _animatedMapMove(x.center, x.zoom);
                  Future.delayed(const Duration(milliseconds: 500)).then(
                    (value) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DetailDialog(
                            provider: document,
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
        nonRotatedChildren: [
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: di.searchBloc.onTextChanged.add,
              controller: _searchFieldController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  onPressed: () {
                    _searchFieldController.clear();
                    di.searchBloc.onTextChanged.add("");
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
