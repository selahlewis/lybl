import 'package:flutter/material.dart';
import 'dart:io';

import 'package:lybl_mobile/util/constants.dart';

enum ImageType { ASSET_IMAGE, FILE_IMAGE, NONE }

class ImagePortrait extends StatelessWidget {
  final double height;
  final String imagePath;
  final ImageType imageType;

  ImagePortrait(
      {@required this.imageType, this.imagePath, this.height = 150.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: kAccentColor),
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.0),
        child: getImage(),
      ),
    );
  }

  Widget getImage() {
    if (imageType == ImageType.NONE || imagePath == null) return null;
    if (imageType == ImageType.FILE_IMAGE) {
      return Image.file(File(imagePath), fit: BoxFit.fill);
    } else if (imageType == ImageType.ASSET_IMAGE) {
      return Image.asset(imagePath, fit: BoxFit.fitHeight);
    } else
      return null;
  }
}
