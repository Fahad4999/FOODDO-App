import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'screen_charity_update_loading.dart';

import '../services.dart';

class DeliveryPersonsAssignment extends StatefulWidget {
  static final routeName = "/deliver-person-assignment";

  @override
  _DeliveryPersonsAssignmentState createState() =>
      _DeliveryPersonsAssignmentState();
}

class _DeliveryPersonsAssignmentState extends State<DeliveryPersonsAssignment> {
  bool _loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = false;
  }

  assignPerson(context, donation, deliveryPerson) async {
    setState(() {
      _loading = true;
    });
    await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Theme.of(ctx).primaryColor,
            title: Text(
              "Select ${deliveryPerson.name} As a Delivery Boy",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SizedBox(),
            actions: [
              ElevatedButton(
                child: Text("Select"),
                onPressed: () async {
                  Navigator.pop(context);
                  await Services.assignDeliveryPerson(
                    donation: donation,
                    deliveryPersons: deliveryPerson,
                  );
                  await Navigator.of(context)
                      .pushReplacementNamed(CharityUpdateLoading.routeName);
                },
              ),
              FlatButton(
                child: Text("Dismiss",style: TextStyle(color: Colors.red),),
                onPressed: () {
                  setState(() {
                    _loading = false;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Fooddo",
              style: TextStyle(
                fontFamily: "Billabong",
                fontSize: 45,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Charity",
              style: TextStyle(
                fontFamily: "Billabong",
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              children: [
                if (Data.deliveryPersons.length == 0)
                  Expanded(
                    child: Center(
                      child: Text(
                        "No Delivery Person with available capacity found for specified area",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  )
                else
                  Container(
                    height: _loading
                        ? MediaQuery.of(context).size.height * 0.87
                        : MediaQuery.of(context).size.height * 0.88,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: Data.deliveryPersons.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          leading: Lottie.asset('assets/delivery.json'),
                          title: Text(
                            Data.deliveryPersons[index].name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Data.deliveryPersons[index].contact,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Capacity (per meal): " +
                                    Data.deliveryPersons[index].vehicleCapacity
                                        .toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          onTap: _loading
                              ? () {}
                              : () => assignPerson(
                                    context,
                                    args["donation"],
                                    Data.deliveryPersons[index],
                                  ),
                        );
                      },
                    ),
                  ),
              ],
            ),
            if (_loading) Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
