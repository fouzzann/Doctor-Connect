import 'package:cc_dr_side/controllers/appointment_controller.dart';
import 'package:cc_dr_side/model/appointment.dart';
import 'package:cc_dr_side/views/widgets/upcoming_appointment/info_colum.dart';
import 'package:cc_dr_side/views/widgets/upcoming_appointment/patient_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  final FirebaseAuth auth;
  final AppointmentController appointmentController;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.auth,
    required this.appointmentController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPatientInfo(),
            const SizedBox(height: 20),
            _buildAppointmentInfo(),
            const SizedBox(height: 20),
            _buildCompleteButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientInfo() {
    return Row(
      children: [
        PatientImage(userEmail: appointment.userEmail),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appointment.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'patient',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(children: []),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row( 
        children: [
          InfoColumn(
            icon: Icons.access_time_rounded,
            label: appointment.appointmentTime,
            value: '',
          ),
          const SizedBox(width: 24),
          InfoColumn(
            icon: Icons.calendar_today_rounded,
            label: DateFormat('dd MMM yyyy').format(appointment.appointmentDate),
            value: '',
          ),
        ],
      ),
    );
  }

  Widget _buildCompleteButton() {
    return Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('appointment')
                  .doc(appointment.id)
                  .update({'status': 'completed'});
              await appointmentController.getUpcomingAppointment(
                'upcoming',
                auth.currentUser!.email.toString(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A78FF),
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Completed',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

