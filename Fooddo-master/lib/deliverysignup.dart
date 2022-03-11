import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import 'classes/delivery_person.dart';

class Data {
  static DeliveryPerson loggedInDeliveryPerson;
  static String userDocId;
}

class DeliverySignUp {
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
      //     String docId = email.replaceAll("@", "").replaceAll(".", "");
      Data.userDocId = email;
      await firebaseFirestore.collection("deliverypersons").doc(email).set({
        "city": city,
        "name": name,
        "phone": phoneNumber,
        "vehicleCapacity": vehicleCapacity,
      });

      fb_auth.UserCredential userCredential = await fb_auth
          .FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

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
