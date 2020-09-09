

import 'package:flutter/material.dart';

class Feeedback extends StatefulWidget {
  @override
  _FeeedbackState createState() => _FeeedbackState();
}

class _FeeedbackState extends State<Feeedback> {
  static const uraanColor = 0xff7ABA7B;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('FeedBack'),
        backgroundColor: Color(uraanColor),
      ),

      body: Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: TextField(
          maxLines: 4,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: 'Feedback here...',
            filled: true,
            //fillColor: Color(0xFFDBEDFF),
            enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ),


    );
  }
}
