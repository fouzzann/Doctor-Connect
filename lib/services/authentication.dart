import 'dart:developer';

import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/screens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
 
  // Google Login
  Future<UserCredential?> loginWithGoogle(Doctor doctorData) async {
     FirebaseAuth _auth=FirebaseAuth.instance;
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }

      final googleAuth = await googleUser.authentication;
      final cred = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(cred);

      if (userCredential.user != null) {
       await dataSubmition(doctorData);
        Get.to(() => HomePage());
      }
      return userCredential;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
  dataSubmition(Doctor doctorData) async{
    try{
       FirebaseAuth _auth=FirebaseAuth.instance;
     await FirebaseFirestore.instance.collection("doctors").doc(_auth.currentUser!.email).set(doctorData.toMap());
    }catch(e){
      log("loging error${e}");
    }
  }
  googleSignOut()async{
    await GoogleSignIn().signOut();
   await FirebaseAuth.instance.signOut();
  }
}