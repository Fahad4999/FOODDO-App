import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fooddo/classes/donation.dart';
import 'package:fooddo/components/continuation_button.dart';
import 'package:fooddo/screens/screen_home.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as im;
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../services.dart';

class ConfirmDonation extends StatefulWidget {
  static final routeName = "/confirm-donation";

  @override
  _ConfirmDonationState createState() => _ConfirmDonationState();
}

class _ConfirmDonationState extends State<ConfirmDonation> {
  int _selectedImage = 0;
  String _name = Data.user.name;
  String _pickUpAddress = Data.user.address;
  bool freshFoodAgreement = false;
  int _waitingTime = 0;
  String _foodName = "";
  String _foodDetails = "";
  Map<String, String> tempMap;
  String uniqueId;
  File _file;
  var _moreImages = List<File>.filled(3, null, growable: false);
  bool _loading = false;
  bool nameMissing = false;
  bool _addingImage = false;
  String _imgUrl;
  int _numberOfImages = 0;
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _pickUpAddressController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _userNameController.text = _name;
    _pickUpAddressController.text = _pickUpAddress;
    uniqueId = Uuid().v4();
  }

  dynamic getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    return {
      "longitude": position.longitude,
      "latitude": position.latitude,
    };
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
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
          margin: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 30,
          ),
          child: (_loading)
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Review Donation",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Food Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
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
                          onChanged: (value) {
                            setState(() {
                              _foodName = value;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Details",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
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
                          onChanged: (value) {
                            setState(() {
                              _foodDetails = value;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        TextField(
                          readOnly: true,
                          controller: _userNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            labelText: "Your Name",
                            labelStyle: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
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
                        SizedBox(height: 10),
                        TextField(
                          readOnly: true,
                          controller: _pickUpAddressController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            labelText: "Street Address",
                            labelStyle: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
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
                          onChanged: (value) {
                            setState(() {
                              _waitingTime = int.parse(value);
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              labelText: "Time:",
                              labelStyle: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                              suffixText: "Minutes",
                              hintText: _waitingTime.toString(),
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
                            onChanged: (value) {
                              if (value.contains('.') || value.contains('-')) {
                                Fluttertoast.showToast(
                                    msg: "Please Enter valid Time");
                                setState(() {
                                  _waitingTime = 0;
                                });
                              } else {
                                setState(() {
                                  _waitingTime = int.parse(value);
                                });
                              }
                            }),
                        SizedBox(height: 10),
                        if (nameMissing)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Please fill the required field",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                    Column(
                      children: [
                        Align(
                          child: Text("Photos"),
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: _addingImage
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : IconButton(
                                          icon: Icon(_file != null
                                              ? Icons.check
                                              : Icons.add),
                                          onPressed: () async {
                                            setState(() {
                                              _addingImage = true;
                                            });
                                            await imageProcessing(
                                                context,
                                                MediaQuery.of(context)
                                                    .size
                                                    .height);
                                            setState(() {
                                              _addingImage = false;
                                            });
                                          },
                                        ),
                                ),
                                // Spacer(),
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _numberOfImages > 3
                                        ? 3
                                        : _numberOfImages,
                                    itemBuilder: (_, index) {
                                      return Container(
                                        margin: EdgeInsets.only(left: 10),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: _addingImage
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : IconButton(
                                                icon: Icon(
                                                  _moreImages[index] == null
                                                      ? Icons.add
                                                      : Icons.check,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () async {
                                                  setState(() {
                                                    _selectedImage =
                                                        (index + 1);
                                                    _addingImage = true;
                                                  });
                                                  await imageProcessing(
                                                      context,
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height);
                                                  setState(() {
                                                    _addingImage = false;
                                                  });
                                                },
                                              ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Center(
                              child: freshFoodAgreement
                                  ? Icon(
                                      Icons.check,
                                      size: 15,
                                    )
                                  : null,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              freshFoodAgreement = !freshFoodAgreement;
                            });
                          },
                        ),
                        Text("I agree that the food is fresh, and not stale."),
                      ],
                    ),
                    ContinuationButton(
                      buttonText: " Submit ",
                      onTap: freshFoodAgreement
                          ? () {
                              String patttern = r'^[a-z A-Z]+$';
                              RegExp regExp = new RegExp(patttern);

                              if ((_foodName == null ||
                                  _foodName.isEmpty ||
                                  _foodDetails == null ||
                                  _foodDetails.isEmpty ||
                                  _waitingTime == 0)) {
                                setState(() {
                                  nameMissing = true;
                                });
                              } else if (!regExp.hasMatch(_foodName)) {
                                Fluttertoast.showToast(
                                    msg: "Please Enter Valid Food Name");
                              } else
                                return showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    title: Text(
                                      'Confirm Donation?',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: SizedBox(),
                                    actions: [
                                      FlatButton(
                                        textColor: Colors.black,
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('CANCEL'),
                                      ),
                                      FlatButton(
                                        textColor: Colors.black,
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          setState(() {
                                            _loading = true;
                                          });
                                          Map<String, double> longlat =
                                              await getCurrentLocation();
                                          var moreImages = List<String>.filled(
                                              3, "",
                                              growable: false);
                                          if (_file != null)
                                            _imgUrl =
                                                await Services.uploadImage(
                                              _file,
                                              fileName: uniqueId + "0",
                                            );
                                          if (_moreImages[0] != null) {
                                            var tempImage =
                                                await Services.uploadImage(
                                              _moreImages[0],
                                              fileName: uniqueId + "1",
                                            );
                                            moreImages[0] = (tempImage);
                                          }
                                          if (_moreImages[1] != null) {
                                            var tempImage =
                                                await Services.uploadImage(
                                              _moreImages[1],
                                              fileName: uniqueId + "2",
                                            );
                                            moreImages[1] = (tempImage);
                                          }
                                          if (_moreImages[2] != null) {
                                            var tempImage =
                                                await Services.uploadImage(
                                              _moreImages[2],
                                              fileName: uniqueId + "3",
                                            );
                                            moreImages[2] = (tempImage);
                                          }
                                          Services.postUserDonation(
                                            new Donation(
                                              foodName: _foodName,
                                              foodDetails: _foodDetails,
                                              city: Data.user.city,
                                              recepient: "Edhi Care Center",
                                              imgUrl: _imgUrl,
                                              date: DateFormat()
                                                  .add_yMd()
                                                  .format(DateTime.now()),
                                              pickupAddress: _pickUpAddress,
                                              serving: int.parse(
                                                  args["servings"]
                                                      .round()
                                                      .toString()),
                                              status: "waiting",
                                              donorId: Data.userPhone,
                                              longlat: longlat,
                                            ),
                                            moreImages: moreImages,
                                            name: _name,
                                            waitingTime: _waitingTime,
                                          );
                                          setState(() {
                                            _loading = false;
                                          });
                                          await Services
                                              .fetchUserPastDonation();
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  Home.routeName);
                                        },
                                        child: Text('ACCEPT'),
                                      ),
                                    ],
                                  ),
                                );
                            }
                          : () {
                              return showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  title: Text(
                                    "ALERT!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    "Please Agree to Fresh Food Agreement",
                                  ),
                                  actions: [
                                    IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              );
                            },
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  compressImage() async {
    final _tempDir = await getTemporaryDirectory();
    final _path = _tempDir.path;
    im.Image imageFile = im.decodeImage(_file.readAsBytesSync());
    final compressedImageFile = File('$_path/img_$uniqueId$_selectedImage.jpg')
      ..writeAsBytesSync(im.encodeJpg(imageFile, quality: 80));
    setState(() {
      _file = compressedImageFile;
      _numberOfImages += 1;
    });
  }

  Future getImageFromCamera() async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    var image = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    setState(() {
      if (_selectedImage == 0)
        _file = File(image.path);
      else if (_selectedImage == 1)
        _moreImages[0] = image as File;
      else if (_selectedImage == 2)
        _moreImages[1] = image as File;
      else if (_selectedImage == 3) _moreImages[2] = image as File;
    });
    await compressImage();
  }

  Future getImageFromGallery() async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      if (_selectedImage == 0)
        _file = image;
      else if (_selectedImage == 1)
        _moreImages[0] = image;
      else if (_selectedImage == 2)
        _moreImages[1] = image;
      else if (_selectedImage == 3) _moreImages[2] = image;
    });
    await compressImage();
  }

  imageProcessing(context, height) {
    //only showing modal bottom sheet
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(top: 30),
        height: height * 0.3,
        child: Column(
          children: <Widget>[
            Text('Select Source'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          size: 50,
                        ),
                        onPressed: getImageFromCamera,
                      ),
                    ),
                    Text("Capture"),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      child: IconButton(
                        icon: Icon(
                          Icons.photo,
                          size: 50,
                        ),
                        onPressed: getImageFromGallery,
                      ),
                    ),
                    Text('Gallery'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
