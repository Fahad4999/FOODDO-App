import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'classes/delivery_person.dart';

class Data {
  static DeliveryPerson loggedInDeliveryPerson;
  static String userDocId;

}

class DeliverySignUp{
  static Future<String> signUp(
      String email,
      String password,
      String name,
      String phoneNumber,
      String city,
      int vehicleCapacity,
      ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      String docId = email.replaceAll("@", "").replaceAll(".", "");
      Data.userDocId = docId;
      await firebaseFirestore.collection("deliverypersons").doc(docId).set({
        "city": city,
        "name": name,
        "phone": phoneNumber,
        "vehicleCapacity": vehicleCapacity,
      });

      return "user-created";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return e.code;
      } else
        return e.code;
    } catch (e) {
      return (e);
    }
  }
}