import 'dart:developer';
import 'package:cc_dr_side/controllers/appointment_controller.dart';
import 'package:cc_dr_side/model/appointment.dart';
import 'package:cc_dr_side/views/widgets/completed_appointment/no_completed_appointment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        return _noAppointmentsMessage();
      }

      return _appointmentListView();
    });
  }

  Widget _noAppointmentsMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.calendar_today_outlined,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'No Upcoming Appointments',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later or add new appointments.',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _appointmentListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: appointmentController.appointmentlist.length,
      itemBuilder: (context, index) {
        final AppointmentModel appointment = appointmentController.appointmentlist[index];
        return AppointmentCard(appointment: appointment);
      },
    );
  }
}
