import 'package:firebase_database/firebase_database.dart';
import 'package:juna_bhajan/data/model/document_change.dart';
import 'package:rxdart/rxdart.dart';

class RXRealtime {
  Stream<DocumentChange> on(Query query) {
    return query.onValue.map((event) => DocumentChange(event.snapshot));
  }

  Stream<DocumentChange> childOn(Query query) {
    return MergeStream([
      query.onChildAdded.map((event) =>
          DocumentChange(event.snapshot, type: DatabaseEventType.childAdded)),
      query.onChildRemoved.map((event) =>
          DocumentChange(event.snapshot, type: DatabaseEventType.childRemoved)),
      query.onChildChanged.map((event) =>
          DocumentChange(event.snapshot, type: DatabaseEventType.childChanged))
    ]);
  }

  Stream<void> add(DatabaseReference ref, dynamic data, {dynamic priority}) {
    if (priority == null) {
      return Stream.fromFuture(ref.set(data));
    } else {
      return Stream.fromFuture(ref.set(data));
    }
  }

  Stream<void> update(DatabaseReference ref, dynamic data) {
    return Stream.fromFuture(ref.update(data));
  }

  Stream<void> delete(DatabaseReference ref) {
    return Stream.fromFuture(ref.remove());
  }

  Stream<DocumentChange> get(Query query) {
    return Stream.fromFuture(query.once()).map((event) {
      return DocumentChange(event.snapshot);
    });
  }
}
