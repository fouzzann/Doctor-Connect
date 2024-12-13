
import 'dart:developer';

import 'package:cc_dr_side/model/appointment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController {
  RxBool isLoading = false.obs;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  RxList<AppointmentModel> appointmentlist = <AppointmentModel> [].obs;
  Future getUpcomingAppointment(String status, String email) async {
    try {
      final QuerySnapshot querySnapshot = await db
          .collection('appointment')
          .where('drGmail', isEqualTo: email)
          .where('status', isEqualTo: status)
          .get();
          final appointments =querySnapshot.docs;
          appointmentlist.assignAll(appointments.map((appointment){
            return AppointmentModel.fromMap(appointment.data() as Map<String,dynamic>, appointment.id);
          }));
    } catch (e) {
      log(e.toString());
    }
  }
}
