import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

class AddEmployees extends StatefulWidget {
  @override
  _AddEmployeesState createState() => _AddEmployeesState();
}

class _AddEmployeesState extends State<AddEmployees> {
  static const uraanColor = 0xff7ABA7B;
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
   bool visible = false; //this is used to hold value for circular progress bar
  //get http => null;
  
Future<List> Task() async {

  setState(() {
    // username = datauser[0]['userEmail'];
  visible=true;
  });


    String lname = lnameController.text;
    String email = emailController.text;
    String fname = fnameController.text;
    String phone = phoneController.text;


    // SERVER API URL
    var url = 'https://www.imadrashid.codes/uraan/add_employee.php';
    //Data
    var data = {'lname': lname,'fname': fname,'email': email,'phone': phone};
    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    var message = json.decode(response.body);
    print(message);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {

      setState(() {
        visible = false;


      });
    }
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

      
    }
    
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Add Employees'),
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
              controller: fnameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'First Name',
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
              controller: lnameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Last Name',
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
              keyboardType: TextInputType.emailAddress,
            controller: emailController,
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
            child: TextField(
              controller: phoneController,
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
                  'Add Employee',
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(uraanColor),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.green),
                ),
                onPressed: Task,
          ),
                ),
          Visibility(
            visible: visible,
            child: Container(
              margin: EdgeInsets.only(bottom: 30),
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}


