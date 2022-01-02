import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddo/components/continuation_button.dart';
import 'package:fooddo/screens/screen_confirm_donation.dart';

class MakeDonation extends StatefulWidget {
  static final String routeName = "/make-donation";

  @override
  _MakeDonationState createState() => _MakeDonationState();
}

class _MakeDonationState extends State<MakeDonation> {
  TextEditingController _servings = new TextEditingController();

  @override
  void initState() {
    _servings.text = "20";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        centerTitle: true,
        title: Text(
          "Fooddo",
          style: TextStyle(
            fontFamily: "Billabong",
            fontSize: 35,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      "assets/plate_assets/empty_plate.svg",
                      height: 400,
                    ),
                    double.parse(_servings.text).round() > 50
                        ? Positioned(
                            top: 50,
                            right: 30,
                            child: SvgPicture.asset(
                              "assets/plate_assets/toast.svg",
                              height: 300,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 100
                        ? Positioned(
                            top: 80,
                            left: 10,
                            child: SvgPicture.asset(
                              "assets/plate_assets/salad_leaf.svg",
                              height: 250,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 200
                        ? Positioned(
                            top: 50,
                            right: 00,
                            child: SvgPicture.asset(
                              "assets/plate_assets/meat.svg",
                              height: 300,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 300
                        ? Positioned(
                            bottom: 100,
                            left: 20,
                            child: SvgPicture.asset(
                              "assets/plate_assets/lemon.svg",
                              height: 200,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 400
                        ? Positioned(
                            top: 50,
                            left: 80,
                            child: SvgPicture.asset(
                              "assets/plate_assets/carrot.svg",
                              height: 200,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 500
                        ? Positioned(
                            bottom: 10,
                            right: 100,
                            child: SvgPicture.asset(
                              "assets/plate_assets/pizza.svg",
                              height: 200,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 600
                        ? Positioned(
                            top: 10,
                            right: 80,
                            child: SvgPicture.asset(
                              "assets/plate_assets/lime.svg",
                              height: 200,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 700
                        ? Positioned(
                            top: 50,
                            right: 30,
                            child: SvgPicture.asset(
                              "assets/plate_assets/mushroom.svg",
                              height: 100,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 800
                        ? Positioned(
                            top: 30,
                            left: 30,
                            child: SvgPicture.asset(
                              "assets/plate_assets/chicken_leg.svg",
                              height: 180,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 900
                        ? Positioned(
                            bottom: 30,
                            right: 30,
                            child: SvgPicture.asset(
                              "assets/plate_assets/fried_egg.svg",
                              height: 180,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() >= 1000
                        ? Positioned(
                            bottom: 80,
                            right: 50,
                            child: SvgPicture.asset(
                              "assets/plate_assets/coriander.svg",
                              height: 250,
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text(
                          "Food Donation for:",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextField(
                            readOnly: true,
                            controller: _servings,
                            enabled: true,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              hintText: double.parse(_servings.text)
                                  .round()
                                  .toString(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Text(
                          "People",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Slider(
                    value: double.parse(_servings.text) > 1000
                        ? 1000
                        : double.parse(_servings.text),
                    min: 2,
                    max: 1000,
                    divisions: 100,
                    label: double.parse(_servings.text).round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _servings.text = value.round().toString();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ContinuationButton(
                        buttonText: "Continue",
                        onTap: () {
                          if (double.parse(_servings.text).round() > 1)
                            Navigator.of(context).pushNamed(
                              ConfirmDonation.routeName,
                              arguments: {
                                "servings": double.parse(_servings.text)
                              },
                            );
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
