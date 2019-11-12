import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static String uid;
  static Future<void> sendVerificationCode({String number}) async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (var data){print("cool");},
      verificationFailed: (AuthException e){print(e.message);},
      codeSent: (String verificationId, [int forceResendingToken]){print('code sent');},
      codeAutoRetrievalTimeout: (String verificationId){print('time out');}
    );
  }
}
