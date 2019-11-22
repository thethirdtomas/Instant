import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instant/utilities/Auth.dart';

class FirestoreStreams {
  static DocumentReference _user =
      Firestore.instance.collection('users').document(Auth.uid);

  static Stream<QuerySnapshot> messagesStream(String compositeId) {
    return Firestore.instance
        .collection('chats')
        .document(compositeId)
        .collection('messages')
        .orderBy('timeSent', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> recipientsStream() {
    return _user.collection('recipients').orderBy('timeSent').snapshots();
  }
}
