import 'package:flutter/material.dart';
import 'package:services_catalog/entities/provider_model.dart';

class DetailDialog extends StatelessWidget {
  final ProviderModel provider;

  const DetailDialog({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(provider.name),
          Text(provider.serviceType),
          Text(provider.address),
          Text(provider.phone)
        ],
      ),
    );
  }

}