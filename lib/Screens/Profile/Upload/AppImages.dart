import 'package:flutter/material.dart';

class AppImages extends StatelessWidget {
  final String url;
  bool rounded;

  AppImages(this.url, {this.rounded = true, @required Image image});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return rounded
        ? ClipRRect(
            borderRadius: BorderRadius.circular(65.0),
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(80))),
              child: Image.asset(url, fit: BoxFit.cover),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(url, fit: BoxFit.cover),
          );
  }
}
