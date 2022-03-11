//Packages Import
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Component Import
import 'package:fooddo/components/continuation_button.dart';
import 'package:lottie/lottie.dart';

import '../services.dart';

class Login extends StatefulWidget {
  static final routeName = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _phoneNumberController = new TextEditingController();
  // bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                    child: Lottie.asset('assets/foodo_lotie.json'),
                  ),
                  Image.asset(
                    "assets/fooddo_logo.png",
                    height: MediaQuery.of(context).size.height / 6,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text('Enter Your Mobile Number',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Roboto")),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextField(
                            controller: _phoneNumberController,
                            autofocus: true,
                            enabled: true,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontFamily: "Roboto"),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              prefixText: "+92 - ",
                              hintText: "3123456789",
                              labelStyle: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ContinuationButton(
                          onTap: () async {
                            if (_phoneNumberController.text.startsWith('0')) {
                              Fluttertoast.showToast(msg: "Please Remove Zero");
                            } else if (_phoneNumberController.text
                                    .contains('.') ||
                                _phoneNumberController.text.contains('-')) {
                              Fluttertoast.showToast(
                                  msg: "Please Remove Special Characters");
                            } else if (_phoneNumberController.text.length <
                                    10 ||
                                _phoneNumberController.text.length > 10) {
                              Fluttertoast.showToast(msg: "Length must be 10");
                            } else if (_phoneNumberController.text.isNotEmpty &&
                                _phoneNumberController.text.length == 10) {
                              print("CALLING");
                              showLoaderDialog(context);

                              await Services.verifyPhone(
                                "+92" + _phoneNumberController.text,
                                context,
                              );
                            }
                          },
                          buttonText: "Continue",
                        ),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
