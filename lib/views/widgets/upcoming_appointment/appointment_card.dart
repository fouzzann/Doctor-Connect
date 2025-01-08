import 'package:cc_dr_side/model/appointment.dart';
import 'package:cc_dr_side/views/screens/patient_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;

  const AppointmentCard({Key? key, required this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PatientDetails(appointment: appointment), transition: Transition.fadeIn);
      },
      child: Container(
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
              _buildAppointmentHeader(),
              const SizedBox(height: 20),
              _buildAppointmentDetails(),
              const SizedBox(height: 20),
              _buildCompletedButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentHeader() {
    return Row(
      children: [
        FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(appointment.userEmail)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildPlaceholderAvatar();
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return const Icon(Icons.person, size: 40, color: Colors.grey);
            }

            final user = snapshot.data!;
            final imageUrl = user['image'];

            return _buildUserAvatar(imageUrl);
          },
        ),
        const SizedBox(width: 16),
        _buildUserInfo(),
      ],
    );
  }

  Widget _buildPlaceholderAvatar() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildUserAvatar(String? imageUrl) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: imageUrl != null && imageUrl.isNotEmpty
            ? Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.person, size: 40, color: Colors.grey);
              })
            : const Icon(Icons.person, size: 40, color: Colors.grey),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appointment.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 4),
          Text(
            'patient',
            style: TextStyle(fontSize: 15, color: Colors.grey[600], fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _buildInfoColumn(Icons.access_time_rounded, appointment.appointmentTime, ''),
          const SizedBox(width: 24),
          _buildInfoColumn(
            Icons.calendar_today_rounded,
            DateFormat('dd MMM yyyy').format(appointment.appointmentDate),
            '',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF64748B), size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(color: Color(0xFF1E293B), fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedButton() {
    return Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance.collection('appointment').doc(appointment.id).update({'status': 'completed'});
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4A78FF),
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Completed',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
