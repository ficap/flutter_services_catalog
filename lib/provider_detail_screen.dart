
import 'package:flutter/material.dart';
import 'package:services_catalog/entities/provider_model.dart';
import 'package:services_catalog/sidebar/page/user_page/specialist_popup.dart';

class ProviderDetailScreen extends StatelessWidget {

  static const routeName = '/provider-detail-screen';
  final ProviderModel model;

  const ProviderDetailScreen(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider detail"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.phone),
        onPressed: () => print("Calling ${model.phone}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("Name: ${model.name}"),
            // Text("ServiceType: ${model.serviceType}"),
            // Text("Address: ${model.address}"),
            // Text("Position: ${model.geopoint.longitude}, ${model.geopoint.latitude}"),
            // Text("Email: ${model.email}"),
            // Text("Phone: ${model.phone}")
            SpecialistPage(model: model),
          ],
        ),
      ),
    );
  }
}
