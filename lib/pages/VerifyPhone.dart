import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instant/pages/CreateProfile.dart';
import 'package:instant/pages/Dashboard.dart';
import 'package:instant/pages/EnterPhone.dart';
import 'package:instant/utilities/Auth.dart';
import 'package:instant/widgets/GradiantButton.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class VerifyPhone extends StatefulWidget {
  final String number;
  VerifyPhone({@required this.number});
  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  bool invalidCode = false;
  bool loading = false;
  var code = MaskedTextController(mask: '000000');
  String verificationId;

  @override
  initState() {
    super.initState();
    Auth.sendVerificationCode(
      number: widget.number,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  verificationCompleted(AuthCredential cred) {
    print("Verification was complete");
    setState(() {
     loading = true;
    });
    signIn(cred);
  }

  verificationFailed(AuthException e) {
    print(e.message);
  }

  codeSent(String vid, [int forceResendingToken]) {
    verificationId = vid;
    print("Code has been sent, this is the vid $vid");
  }

  codeAutoRetrievalTimeout(String vid) {
    print("Time out, this is the vid $vid");
  }

  confirmCode() {
    setState(() {
     loading = true; 
    });
    AuthCredential cred = Auth.verifyCode(code.text, verificationId);
    signIn(cred);
  }

  signIn(AuthCredential cred) async {
    if (await Auth.signIn(cred)) {
      if(await Auth.userExist()){
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
      }else{
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CreateProfile()));
      }
      
    } else {
      setState(() {
        loading = false;
        invalidCode = true;
        code.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => EnterPhone()));
                  },
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(invalidCode ? "Invalid Code" : "Verify Phone",
                      style: TextStyle(
                          color: invalidCode ? Colors.redAccent : Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 33)),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: code,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.code,
                          color: Colors.grey,
                        ),
                        hintText: "Verification Code",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "We have sent a verification code to ${widget.number}. Please enter the six digit code to start using Instant.",
                    style: TextStyle(
                        color: Colors.green[100], fontFamily: "Montserrat"),
                  ),
                ),
              ],
            ),
            loading?SpinKitWave(color: Colors.white, size: 30.0)
            :GradiantButton(
              onTap: confirmCode,
              text: "Confirm Code",
            )
          ],
        ),
      ),
    );
  }
}
