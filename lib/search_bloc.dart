import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:services_catalog/entities/provider_model.dart';


class SearchBloc {
  final Sink<String> onTextChanged;
  final Stream<Iterable<ProviderModel>> state;

  factory SearchBloc(CollectionReference<ProviderModel> providers) {
    final Stream<Iterable<ProviderModel>> snapshots = providers.snapshots()
        .map((event) {
      return event.docs.map((e) {
        return e.data();
      });
    });

    final onTextChanged = PublishSubject<String>();

    final textStream = onTextChanged
        .distinct()
        .debounceTime(const Duration(milliseconds: 250))
        .startWith("");

    final state = Rx.combineLatest2(
        snapshots, textStream, (Iterable<ProviderModel> snapshot, String text) {
      if (text.isEmpty) return snapshot;

      return snapshot.where((element) =>
      element.serviceType.toLowerCase()
          .startsWith(text.toLowerCase()) ||
          element.name.toLowerCase().contains(text.toLowerCase()));
    });


    return SearchBloc._(onTextChanged, state);
  }

  SearchBloc._(this.onTextChanged, this.state);

  void dispose() {
    onTextChanged.close();
  }

}
