import 'package:flutter/material.dart';
import './sign_in.dart';
import './sign_up.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity/connectivity.dart';

class SignInUp extends StatefulWidget {
  @override
  _SignInUpState createState() => _SignInUpState();
}

class _SignInUpState extends State<SignInUp> {
  static const uraanColor = 0xff7ABA7B;

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      showToasty();
    }
  }

  void showToasty() {
    Fluttertoast.showToast(
      msg: "no internet connection",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(uraanColor),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Image.asset(
              'images/uraanicon.png',
              width: 300,
              height: 400,
            ),
            new SizedBox(
              width: 300,
              child: RaisedButton(
                padding: EdgeInsets.all(5),
                color: Colors.white,
                child: new Text(
                  'Sign in',
                  style: TextStyle(color: Color(uraanColor), fontSize: 20),
                ),
                onPressed: () {
                  _checkInternetConnectivity();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.white),
                ),
              ),
            ),
            //////////////////////////////////////////////////
            /////////////////////////////////
            ///
            ///
            new SizedBox(
              width: 300,
              child: RaisedButton(
                color: Color(uraanColor),
                padding: EdgeInsets.all(5),
                child: new Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  _checkInternetConnectivity();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
