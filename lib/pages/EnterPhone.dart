import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instant/pages/VerifyPhone.dart';
import 'package:instant/widgets/GradiantButton.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class EnterPhone extends StatefulWidget {
  @override
  _EnterPhoneState createState() => _EnterPhoneState();
}

class _EnterPhoneState extends State<EnterPhone> {
  bool invalidNumber = false;
  var number = MaskedTextController(mask: '(000) 000-0000');

  String formatNumber() {
    String formattedNumber = '+1';
    number.text.runes.forEach((char) {
      if (char > 47 && char < 58) {
        formattedNumber += String.fromCharCode(char);
      }
    });

    return formattedNumber;
  }

  sendCode() {
    if (number.text.length == 14) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => VerifyPhone(
                    number: formatNumber(),
                  )));
    } else {
      setState(() {
        invalidNumber = true;
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
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(invalidNumber ? "Invalid Phone" : "Your Phone",
                      style: TextStyle(
                          color:
                              invalidNumber ? Colors.redAccent : Colors.white,
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
                    controller: number,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.grey,
                        ),
                        hintText: "Phone Number",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Please enter your phone number in order to start using Instant.",
                    style: TextStyle(
                        color: Colors.green[100], fontFamily: "Montserrat"),
                  ),
                ),
              ],
            ),
            GradiantButton(
              onTap: sendCode,
              text: "Confirm Phone",
            )
          ],
        ),
      ),
    );
  }
}
