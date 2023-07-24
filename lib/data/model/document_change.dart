import 'package:firebase_database/firebase_database.dart';

class DocumentChange {
  DataSnapshot snapshot;
  DatabaseEventType? type;

  DocumentChange(this.snapshot, {this.type});

  DataSnapshot getSnapshot() {
    return snapshot;
  }

  DatabaseEventType? getType() {
    return type;
  }
}
