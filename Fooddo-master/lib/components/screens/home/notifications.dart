import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../services.dart';
import '../../notification_tile.dart';

class NotificationsComponet extends StatefulWidget {
  @override
  _NotificationsComponetState createState() => _NotificationsComponetState();
}

class _NotificationsComponetState extends State<NotificationsComponet> {
  DateTime currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Exit warning");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.78,
        margin: EdgeInsets.only(top: 0),
        child: Data.notifications.length > 0
            ? ListView.builder(
                itemBuilder: (builder, index) {
                  return NotificationTile(
                    notification: Data.notifications[index],
                    height: MediaQuery.of(context).size.height,
                  );
                },
                itemCount: Data.notifications.length,
              )
            : Center(
                child: Text(
                  "No Notifications",
                ),
              ),
      ),
    );
  }
}
