import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instant/utilities/Auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreTask {
  static Future<bool> usernameExist(String username) async {
    QuerySnapshot q = await Firestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .getDocuments();

    if (q.documents.length != 0) {
      return true;
    }

    return false;
  }

  static void createProfile(
      {String name, String username, String bio, String profileImage}) {
    Firestore.instance.collection('users').document(Auth.uid).setData({
      'name': name,
      'username': username,
      'bio': bio,
      'profileImage': profileImage,
    });
  }

  static Future<String> uploadImage(File profileImage) async {
    try {
      StorageReference fsr =
          FirebaseStorage.instance.ref().child('profileImages/${Auth.uid}.jpg');
      StorageUploadTask task = fsr.putFile(profileImage);
      StorageTaskSnapshot imageUrl = await task.onComplete;
      return await imageUrl.ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  static Future<Map> findRecipient(String username) async {
    QuerySnapshot q = await Firestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .getDocuments();

    if (q.documents.length == 1) {
      Map recipient = q.documents[0].data;
      String recipientId = q.documents[0].documentID;
      if (recipientId != Auth.uid) {
        recipient['id'] = recipientId;
        return recipient;
      }
    }
    return null;
  }

  static void sendMessage({String recipientId, String message}) {
    String compositeId = getCompositeId(recipientId);
    Timestamp now = Timestamp.now();

    //updates users data
    Firestore.instance
        .collection('users')
        .document(Auth.uid)
        .collection('recipients')
        .document(recipientId)
        .setData({
      'lastMessage': message,
      'timeSent': now,
    });
    //updates recipients data
    Firestore.instance
        .collection('users')
        .document(recipientId)
        .collection('recipients')
        .document(Auth.uid)
        .setData({
      'lastMessage': message,
      'timeSent': now,
    });

    //addes message to chat
    Firestore.instance
        .collection('chats')
        .document(compositeId)
        .collection('messages')
        .document()
        .setData({
          'message': message,
          'timeSent': now,
          'user':Auth.uid,
        });
  }

  static String getCompositeId(String recipientId) {
    if (Auth.uid.compareTo(recipientId) == -1) {
      return Auth.uid + recipientId;
    }
    return recipientId + Auth.uid;
  }
}
