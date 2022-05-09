import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CircularMarker extends Marker {
  static Widget Function(BuildContext) _widgetBuilder(String s, void Function()? onTap) {
    return (BuildContext context) {
      return GestureDetector(
        child: CircleAvatar(
          child: Text(
            s,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red.withAlpha(225),
          foregroundColor: Colors.white,
        ),
        onTap: onTap,
      );
    };
  }

  CircularMarker(
      {required LatLng point, void Function()? onTap, String label = ""})
      : super(
          point: point,
          builder: _widgetBuilder(label, onTap),
          rotate: true,
          anchorPos: AnchorPos.align(AnchorAlign.center),
        );
}
