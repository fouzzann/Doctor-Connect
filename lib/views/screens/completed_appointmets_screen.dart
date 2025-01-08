import 'package:cc_dr_side/views/screens/patient_details.dart';
import 'package:cc_dr_side/views/widgets/completed_appointment/no_completed_appointment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cc_dr_side/controllers/appointment_controller.dart';
import 'package:cc_dr_side/model/appointment.dart';


class CompletedAppointment extends StatefulWidget {
  const CompletedAppointment({super.key});

  @override
  State<CompletedAppointment> createState() => _CompletedAppointmentState();
}

class _CompletedAppointmentState extends State<CompletedAppointment> {
  final AppointmentController appointmentController =
      Get.put(AppointmentController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await appointmentController.getUpcomingAppointment(
        'completed',
        _auth.currentUser!.email.toString(),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (appointmentController.appointmentlist.isEmpty) {
        return const NoCompletedAppointments();
      }

      return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: appointmentController.appointmentlist.length,
        itemBuilder: (context, index) {
          final AppointmentModel appointment =
              appointmentController.appointmentlist[index]; 
          return GestureDetector(
            onTap: () {
              Get.to(() => PatientDetails(appointment: appointment),
                  transition: Transition.fadeIn);
            },
            child: AppointmentCard(appointment: appointment), 
          );
        },
      );
    });
  }
}
