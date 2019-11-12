import 'package:firebase_auth/firebase_auth.dart';

class Auth {
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

  static Future<void> signIn(AuthCredential cred) async{
    AuthResult result = await FirebaseAuth.instance.signInWithCredential(cred);
    print("This is the users id ${result.user.uid}");
  }

  static AuthCredential verifyCode(String smsCode, String verificationId) {
    AuthCredential cred = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);
    print("This is the creditantls $cred");
    return cred;
  }
}
