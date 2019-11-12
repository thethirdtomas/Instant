import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instant/pages/EnterPhone.dart';
import 'package:instant/utilities/Auth.dart';
import 'package:instant/widgets/GradiantButton.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class VerifyPhone extends StatefulWidget {
  final String number;
  VerifyPhone({@required this.number});
  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  bool invalidCode = false;
  var code = MaskedTextController(mask: '000000');

  @override
  initState() {
    super.initState();
    Auth.sendVerificationCode(number: widget.number);
  }

  confirmCode() {}

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
            GradiantButton(
              onTap: confirmCode,
              text: "Confirm Code",
            )
          ],
        ),
      ),
    );
  }
}
