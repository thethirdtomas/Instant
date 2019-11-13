import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static String uid;
  static Future<void> sendVerificationCode({
      String number,
      Function(AuthCredential) verificationCompleted,
      Function(AuthException) verificationFailed,
      Function (String, [int]) codeSent,
      Function (String) codeAutoRetrievalTimeout
  }) async {
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  static Future<bool> signIn(AuthCredential cred) async{
    try{
      AuthResult result = await FirebaseAuth.instance.signInWithCredential(cred);
      uid = result.user.uid;
      return true;
    }catch(e){
      return false;
    }
    
  }

  static AuthCredential verifyCode(String smsCode, String verificationId) {
    AuthCredential cred = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);
    return cred;
  }
}
