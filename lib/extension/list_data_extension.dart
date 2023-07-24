import 'dart:async';
import 'dart:collection';

import 'package:fimber/fimber.dart';
import 'package:juna_bhajan/data/model/document_change.dart';
import 'package:juna_bhajan/data/model/list_data.dart';

extension ListDaraExtension on Stream<DocumentChange> {
  Stream<ListData> parseToListData() {
    return map((event) {
      Fimber.d("parseToListData  ${event.snapshot.key}");
      return ListData(
          id: event.snapshot.key,
          data: event.snapshot.value as LinkedHashMap<dynamic, dynamic>?);
    });
  }

  Stream<List<String>> parseToListOfString() {
    return map((event) {
      if (event.snapshot.value == null) {
        return <String>[];
      } else {
        return (event.snapshot.value as List<dynamic>).cast<String>();
      }
    }).map((event) {
      Fimber.d("parseToListOfString $event");
      return event;
    });
  }

  Stream<List<String>> parseArrayToListOfString() {
    return map((event) {
      if (event.snapshot.value == null) {
        return <String>[];
      } else {
        return Map<String, dynamic>.from(
                event.snapshot.value as Map<dynamic, dynamic>)
            .entries
            .map((e) => e.key)
            .toList();
      }
    }).map((event) {
      Fimber.d("parseArrayToListOfString $event");
      return event;
    });
  }

  Stream<List<ListData>> parseToListOfListData() {
    return map((event) {
      if (event.snapshot.value != null) {
        return (event.snapshot.value as LinkedHashMap<dynamic, dynamic>)
            .entries
            .map((event) {
          return ListData(id: event.key, data: event.value);
        }).toList();
      } else {
        return <ListData>[];
      }
    }).map((event) {
      Fimber.d("parseToListOfListData ${event.map((e) => e.id).toList()}");
      return event;
    });
  }
}
