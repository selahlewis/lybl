import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';
import 'package:lybl_mobile/Screens/Widgets/image_portrait.dart';
import 'package:lybl_mobile/Screens/Widgets/rounded_icon_button.dart';

class AddPhotoScreen extends StatefulWidget {
  final Function(String) onPhotoChanged;

  AddPhotoScreen({@required this.onPhotoChanged});

  @override
  _AddPhotoScreenState createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
  final picker = ImagePicker();
  String _imagePath;

  Future pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      widget.onPhotoChanged(pickedFile.path);

      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCodes.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(
                  flex: 1,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 300, height: 300),
                  child: Image.asset('assets/images/tempLoginImage.PNG'),
                ),
                Text(
                  'Add Photo',
                  style: TextStyle(
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.bold,
                      color: ColorCodes.mainColorDark,
                      fontSize: 45),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(
                      flex: 10,
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorCodes.mainColorLight),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorCodes.mainColorLight),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorCodes.mainColorDark),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorCodes.mainColorLight),
                    ),
                    Spacer(
                      flex: 10,
                    ),
                  ],
                ),
                Spacer(
                  flex: 1,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: 20.0, top: 20),
                            child: _imagePath == null
                                ? CircleAvatar(
                                    radius: 75, // Image radius
                                    backgroundImage: AssetImage(
                                        'assets/images/user-default.jpg'),
                                  )
                                : CircleAvatar(
                                    radius: 75, // Image radius
                                    backgroundImage:
                                        FileImage(File(_imagePath))),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: RoundedIconButton(
                                onPressed: pickImageFromGallery,
                                iconData: Icons.edit,
                                iconSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 300, height: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.REGISTER3);
                    },
                    child: Icon(Icons.navigate_next),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: ColorCodes.mainColorLight,
                    ),
                  ),
                ),
                Spacer(
                  flex: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
