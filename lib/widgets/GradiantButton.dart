import 'package:flutter/material.dart';
import 'package:instant/utilities/AppColors.dart';


class GradiantButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  GradiantButton({@required this.text, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      height: 50,
      width: 1.0 / 0.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: AppColors.greenGradiant,
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
          stops: [0.0, 1.0],
          tileMode: TileMode.repeated,
        )
      ),
      child: FlatButton(
        onPressed: this.onTap,
        child: Text(
          this.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Montserrat'
          )
        ),
      ),
    );
  }
}