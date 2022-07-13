
import 'package:flutter/material.dart';

class MultiSelectLogic extends ChangeNotifier {

  List<Widget> ch = [];
  bool choice1 = false, choice2 = false, choice3 = false;
  List<bool> chs = [];

  setOptionState(int option, bool value) {
    switch(option){
      case 0:
        choice1 = value;
    }
    notifyListeners();
  }

  // setChoices(List<String> choices){
  //
  //   print(choices.length);
  //
  //   for(int i = 0; i < choices.length; i++){
  //
  //     chs.add(false);
  //
  //     Widget choice = Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text("${choices[i]}"),
  //         Checkbox(
  //           checkColor: Colors.white,
  //           fillColor: MaterialStateProperty.resolveWith(getColor),
  //           value: choice1,
  //           onChanged: (bool? value) {
  //             // add selected
  //             choice1 = value!;
  //
  //             print("checked ${choice1}");
  //             notifyListeners();
  //           },
  //         )
  //       ],
  //     );
  //     ch.add(choice);
  //   }
  //
  //   return ch;
  //
  //   //notifyListeners();
  //
  // }


}