import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:characters/characters.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  // var _usernameController = TextEditingController();

  static const uraanColor = 0xff7ABA7B;
  bool passwordVisible; //used to hold values for password states
  bool visible = false; //this is used to hold value for circular progress bar
  String _usernameError;

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

/////////////User Regitration Function///////////////////
  Future userRegistration() async {
    setState(() {
      visible = true;
    });

    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String phone = mobileController.text;

    // SERVER API URL
    var url = 'https://www.imadrashid.codes/uraan/register_user.php';

    // Store all data with Param Name.
    var data = {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }

    // Showing Alert Dialog with Response JSON Message.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    // final response = await http.post("https://www.imadrashid.codes/uraan/register_user.php", body: {
    //   "name": name.text,
    //   "mobile": mobile.text,
    //   "email": email.text,
    //   "password": password.text,
    // });
  }

/////////////User Regitration Function Ends here///////////////////

  // validate() {
  //   if (!validateStructure(_usernameController.text)) {
  //     setState(() {
  //       _usernameError = 'passwrod must be greater than 6';
  //       return;
  //       // _passwordError = passwordError;
  //     });
  //     // show dialog/snackbar to get user attention.
  //     senddata();
  //   }
  // }

  @override
  void initState() {
    passwordVisible = true;
    // CpasswordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Sign Up'),
        backgroundColor: Color(uraanColor),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Container(
            child: Text(
              'Uraan - Changing Perspectives.',
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Full Name',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 0.0),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                suffixIcon: Icon(
                  Icons.person,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 0.0),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                suffixIcon: Icon(
                  Icons.mail,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: passwordController,
              obscureText: passwordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _usernameError,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 0.0),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: TextField(
              keyboardType: TextInputType.text,
              obscureText: passwordVisible,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 0.0),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: TextField(
              controller: mobileController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 0.0),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                suffixIcon: Icon(
                  Icons.phone,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: RaisedButton(
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              color: Color(uraanColor),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.green),


              ),
              onPressed: userRegistration,
            ),
          ),
          Visibility(
              visible: visible,
              child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: CircularProgressIndicator())),
        ],
      ),
    );
  }
}
