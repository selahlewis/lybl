
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lybl_mobile/Environment/Globals.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';
import 'package:lybl_mobile/Screens/Profile/Upload/UploadLogic.dart';
import 'package:provider/provider.dart';

class Upload extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => UploadState();

}

class UploadState extends State<Upload> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<UploadLogic>(
        builder: (context, logic, child){
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text('Profile Picture'),
                        Container(height: 10,),
                        logic.img,
                        Container(height: 10,),
                        ElevatedButton(
                          onPressed: () => logic.uploadMain(context),
                          child: Text("Upload"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    child: Divider(
                      thickness: 1, // thickness of the line
                      indent: 20, // empty space to the leading edge of divider.
                      endIndent: 20, // empty space to the trailing edge of the divider.
                      color: ColorCodes.mainColorLight, // The color to use when painting the line.
                      height: 20, // The divider's height extent.
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text('Additional Images'),
                        Container(
                          height: 15,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 3,
                          children: logic.addImages,
                        ),
                        Container(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () => logic.uploadImages(context),
                          child: Text("Add Images"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}