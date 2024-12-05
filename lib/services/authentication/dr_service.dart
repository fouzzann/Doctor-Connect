import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Future<bool> CheckDrAccepted(String email) async {
   
    try {
       log('ewhfh');
      final DocumentSnapshot snapshot =
          await db.collection("doctors").doc(email).get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
      
        if (data['isAccepted']) { 
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
