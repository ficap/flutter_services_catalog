import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_catalog/di.dart';
import 'package:services_catalog/map_screen.dart';
import 'package:services_catalog/sidebar/sidebar.dart';

import '../page/add_user_page.dart';

class HomePage extends StatefulWidget {
  static String id = "home";
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


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
              child: MapScreen()),
      ),
    );

  }


}