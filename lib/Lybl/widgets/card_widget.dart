import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CardCourses extends StatelessWidget {
  String image;
  final String title;
  final String hours;
  final String progress;
  final double percentage;
  final Color color;

  CardCourses({
    Key key,
    @required this.image,
    @required this.title,
    @required this.hours,
    @required this.percentage,
    @required this.progress,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: color,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 80,
                margin: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    hours,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFFF18C8E),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          Divider(),
          Container(
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            height: 24,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.play_arrow,
                  color: Color(0xFFACACAC),
                ),
                SizedBox(width: 80),
                Text(
                  'View Course',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
