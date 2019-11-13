import 'dart:io';
import 'package:flutter/material.dart';
import 'package:instant/widgets/GradiantButton.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  File profileImage;

  getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
     profileImage = image; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Your Profile",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 33)),
            ),
            GestureDetector(
              onTap: getImage,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: profileImage == null
                            ? AssetImage('assets/default.png')
                            : FileImage(profileImage),
                        fit: BoxFit.fill)),
              ),
            ),
            Column(
              children: <Widget>[
                TextField(
                  maxLength: 30,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      hintText: "Full Name",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
                TextField(
                  maxLength: 30,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.fingerprint,
                        color: Colors.grey,
                      ),
                      hintText: "Username",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
                TextField(
                  maxLength: 200,
                  minLines: 1,
                  maxLines: 5,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.language,
                        color: Colors.grey,
                      ),
                      hintText: "Bio",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                )
              ],
            ),
            GradiantButton(
              text: "Create Profile",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
