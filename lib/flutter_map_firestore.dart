import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/plugin_api.dart';

// inspired by https://github.com/appvinio/flutter_map_firestore

typedef MarkerCreator = Marker Function(Object document);

class FirestoreMarkerPlugin<T> extends MapPlugin {
  @override
  Widget createLayer(LayerOptions options, MapState mapState, Stream<Null>? stream) {
    FirestoreMarkerLayerOptions<T> fireOption =
    options as FirestoreMarkerLayerOptions<T>;
    return StreamBuilder<QuerySnapshot<T>>(
        stream: fireOption._reference.snapshots(),
        builder: <T>(context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
              width: 0.0,
              height: 0.0,
            );
          }
          if (snapshot.data?.docs.isEmpty ?? true) {
            return const SizedBox(
              width: 0.0,
              height: 0.0,
            );
          }

          List<Marker> markers = [];
          for (DocumentSnapshot<T> document in snapshot.data!.docs){
            if (document.data() != null) {
              markers.add(fireOption._creator(document.data()!));
            }
          }

          MarkerLayerOptions markerOpts = MarkerLayerOptions(markers: markers);

          return MarkerLayer(markerOpts, mapState, stream);
        });
  }

  @override
  bool supportsLayer(LayerOptions options) {
    return options is FirestoreMarkerLayerOptions<T>;
  }
}

class FirestoreMarkerLayerOptions<T> extends LayerOptions {
  final CollectionReference<T> _reference;
  final MarkerCreator _creator;

  FirestoreMarkerLayerOptions({
    required CollectionReference<T> collectionReference,
    required MarkerCreator markerCreator
  }) : _reference = collectionReference, _creator = markerCreator;
}
