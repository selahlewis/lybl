import 'package:flutter/material.dart';
import 'package:lybl_mobile/util/constants.dart';

class RoundedOutlinedButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  RoundedOutlinedButton({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          onSurface: kAccentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(text, style: Theme.of(context).textTheme.button),
        onPressed: onPressed,
      ),
    );
  }
}
