import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/views/widgets/dr_account_details_page/build_info_row.dart';
import 'package:cc_dr_side/views/widgets/dr_account_details_page/profile_Image_and_basic_Info.dart';
import 'package:flutter/material.dart';

class DetailedInformation extends StatelessWidget {
  const DetailedInformation({super.key, required this.doctor});
  final Doctor doctor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInfoRow('Age', doctor.age),
          buildInfoRow('Gender', doctor.gender),
          buildInfoRow('Email', doctor.email),
          buildInfoRow('Hospital', doctor.hospitalName),
          const SizedBox(height: 16),
          const SizedBox(height: 16),
          Text(
            'Medical Certificate',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => showZoomableImage(context, doctor.certificateImage),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  doctor.certificateImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
