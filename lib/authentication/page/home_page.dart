import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_catalog/di.dart';
import 'package:services_catalog/map_screen.dart';
import 'package:services_catalog/sidebar/sidebar.dart';


class HomePage extends StatelessWidget {
  static String id = "home";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      drawer: SideBar(),
      body:
      Center(
          child: Provider<DI>(
              create: (context) => DI(),
              dispose: (context, di) => di.dispose(),
              child: const MapScreen()),
      ),
    );

  }


}