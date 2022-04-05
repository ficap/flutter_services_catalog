import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:services_catalog/entities/provider_model.dart';
import 'package:services_catalog/flutter_map_firestore.dart';
import 'package:services_catalog/provider_detail_screen.dart';

class MapScreen extends StatelessWidget {

  static const routeName = '/map-screen';

  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _providersCollection = FirebaseFirestore.instance
        .collection('providers').withConverter<ProviderModel>(
          fromFirestore: (document, options) => ProviderModel.fromJson(document.data()!),
          toFirestore: (model, options) => model.toJson(),
        );

    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(49.19085645871488, 16.60749357920382),
          zoom: 13.0,
          plugins: [FirestoreMarkerPlugin()],
          maxZoom: 18.0
            
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            attributionBuilder: (_) {
              return const Text("© OpenStreetMap contributors");
            },
          ),
          FirestoreMarkerLayerOptions<ProviderModel>(
            collectionReference: _providersCollection,
            markerCreator: <ProviderModel>(document) {
              // todo: check if not null
              return Marker(
                point: LatLng(document.geopoint.latitude, document.geopoint.longitude),
                rotate: true,
                anchorPos: AnchorPos.align(AnchorAlign.center),
                builder: (context) {
                  return GestureDetector(
                    child: CircleAvatar(
                      child: Text(
                        (document.serviceType as String).characters.first.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.red.withAlpha(225),
                      foregroundColor: Colors.white,
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return ProviderDetailScreen(document);
                        }
                      ),
                    ),
                  );
                },
              );
            }
          ),
        ],
      )
    );
  }
}
