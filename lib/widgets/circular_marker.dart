import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';

class CircularMarker extends Marker {
  static const _serviceTypes = {
    "plumber": FontAwesomeIcons.sink,
    "electrician": FontAwesomeIcons.plugCircleExclamation,
    "cleaner": FontAwesomeIcons.broom,
    "doctor": FontAwesomeIcons.userDoctor,
    "painter": FontAwesomeIcons.paintRoller,
    "builder": FontAwesomeIcons.trowelBricks,
    "mover": FontAwesomeIcons.truckRampBox,
    "repairman": FontAwesomeIcons.screwdriverWrench,
  };

  static Widget Function(BuildContext) _widgetBuilder(
      String s, void Function()? onTap) {
    return (BuildContext context) {
      Widget? child;
      if (_serviceTypes.containsKey(s.toLowerCase())) {
        child = FaIcon(
          _serviceTypes[s.toLowerCase()],
          color: Colors.white,
          semanticLabel: s.toLowerCase(),
          size: 15,
        );
      }
      child ??= Text(
        s.characters.first.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      );

      return GestureDetector(
        child: CircleAvatar(
          child: child,
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
