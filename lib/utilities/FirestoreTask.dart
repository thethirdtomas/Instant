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

  static void createProfile({String name, String username, String bio, String profileImage}){
    Firestore.instance.collection('users').document(Auth.uid).setData({
      'name': name,
      'username': username,
      'bio':bio,
      'profileImage': profileImage,
    });
  }

   static Future<String> uploadImage(File profileImage) async{
    try{
    StorageReference fsr = FirebaseStorage.instance.ref().child('profileImages/${Auth.uid}.jpg');
    StorageUploadTask task = fsr.putFile(profileImage);
    StorageTaskSnapshot imageUrl = await task.onComplete;
    return await imageUrl.ref.getDownloadURL();
    
    }
    catch(e){
      return null;
    }
  }
}
