import 'package:cc_dr_side/controllers/appointment_controller.dart';
import 'package:cc_dr_side/model/appointment.dart';
import 'package:cc_dr_side/views/screens/patient_details.dart';
import 'package:cc_dr_side/views/widgets/upcoming_appointment/appointment_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentListView extends StatelessWidget {
  final List<AppointmentModel> appointments;
  final FirebaseAuth auth;
  final AppointmentController appointmentController;

  const AppointmentListView({
    super.key,
    required this.appointments,
    required this.auth,
    required this.appointmentController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return GestureDetector(
          onTap: () {
            Get.to(
              () => PatientDetails(appointment: appointment),
              transition: Transition.fadeIn,
            );
          },
          child: AppointmentCard(
            appointment: appointment,
            auth: auth,
            appointmentController: appointmentController,
          ),
        );
      },
    );
  }
}