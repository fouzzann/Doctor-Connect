import 'package:cc_dr_side/views/widgets/patient_details/appointment_details.dart';
import 'package:cc_dr_side/views/widgets/patient_details/user_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cc_dr_side/model/appointment.dart';

class PatientDetails extends StatelessWidget { 
  final AppointmentModel appointment;
  
  const PatientDetails({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1E293B)),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Color(0xFF1E293B)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserDetails(appointment: appointment),
            AppointmentDetails(appointment: appointment),
          ],
        ),
      ),
    );
  }
}
