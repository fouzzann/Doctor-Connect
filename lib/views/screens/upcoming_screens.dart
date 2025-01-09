import 'package:cc_dr_side/controllers/appointment_controller.dart';
import 'package:cc_dr_side/views/widgets/upcoming_appointment/appointment_list_view.dart';
import 'package:cc_dr_side/views/widgets/upcoming_appointment/no_appointmets_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class UpcomingScreens extends StatefulWidget {
  const UpcomingScreens({super.key});

  @override
  State<UpcomingScreens> createState() => _UpcomingScreensState();
}

class _UpcomingScreensState extends State<UpcomingScreens> {
  final AppointmentController appointmentController = Get.put(AppointmentController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await appointmentController.getUpcomingAppointment(
        'upcoming',
        _auth.currentUser!.email.toString(),
      );
      log(_auth.currentUser!.email.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (appointmentController.appointmentlist.isEmpty) {
        return const NoAppointmentsView();
      }
      return AppointmentListView(
        appointments: appointmentController.appointmentlist,
        auth: _auth, 
        appointmentController: appointmentController,
      );
    });
  }
}


















