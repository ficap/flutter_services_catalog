import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:services_catalog/entities/provider_model.dart';
import 'package:services_catalog/search_bloc.dart';

class DI {
  final SearchBloc searchBloc;
  final CollectionReference<ProviderModel> providerModelCollection;

  factory DI() {
    final _providersCollection = FirebaseFirestore.instance
        .collection('providers')
        .withConverter<ProviderModel>(
      fromFirestore: (document, options) =>
          ProviderModel.fromJson(document.data()!),
      toFirestore: (model, options) => model.toJson(),
    );

    return DI._(SearchBloc(_providersCollection), _providersCollection);
  }

  DI._(this.searchBloc, this.providerModelCollection);

  void dispose() {
    searchBloc.dispose();
  }
}