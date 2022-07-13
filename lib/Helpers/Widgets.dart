import 'package:flutter/material.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';

class Widgets {
  static Widget input(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorCodes.mainColorLight,
            ),
          )),
    );
  }

  static Widget inputMultiline(TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorCodes.mainColorLight,
            ),
          )),
    );
  }
}
