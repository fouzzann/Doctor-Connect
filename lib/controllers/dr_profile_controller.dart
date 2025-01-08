import 'dart:io';
import 'package:cc_dr_side/functions/upload_image_s3bucket.dart';
import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/views/screens/docter_add/select_available_days.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DoctorProfileController {
  File? image;
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final hospitalNameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final categoryController = TextEditingController();
  final yearsOfExperienceController = TextEditingController();
  final consultationFeeController = TextEditingController();
  final locationController = TextEditingController();
  final mobileNumberController = TextEditingController();

  void setImage(File newImage) {
    image = newImage;
  }

  Future<void> submitForm(BuildContext context) async {
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please add an image'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xFF4A78FF),
            ),
          );
        },
      );

      try {
        final String? profileUrl = await uploadImage(image!);
        final doctorModel = Doctor(
          contact: mobileNumberController.text,
          image: profileUrl ?? '',
          fullName: fullNameController.text,
          age: ageController.text,
          email: '',
          gender: genderController.text,
          uid: '',
          category: categoryController.text,
          hospitalName: hospitalNameController.text,
          location: locationController.text,
          isAccepted: false,
          consultationFee: consultationFeeController.text,
          yearsOfExperience: yearsOfExperienceController.text,
          certificateImage: '',
          availableDays: [],
        );

        Navigator.pop(context); // Close loading dialog

        Get.to(
          () => DayPage(doctor: doctorModel),
          transition: Transition.rightToLeftWithFade,
        );
      } catch (error) {
        Navigator.pop(context); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occurred: $error'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  // ignore: override_on_non_overriding_member
  void dispose() {
    fullNameController.dispose();
    hospitalNameController.dispose();
    ageController.dispose();
    genderController.dispose();
    categoryController.dispose();
    yearsOfExperienceController.dispose();
    consultationFeeController.dispose();
    locationController.dispose();
    mobileNumberController.dispose();
  }
}

// lib/core/constants/doctor_categories.dart
class DoctorCategories {
  static const List<String> list = [
    'Addiction Medicine Specialist',
    'Allergist/Immunologist',
    'Anesthesiologist',
    'Cardiologist',
    'Chiropractor',
    'Clinical Pharmacologist',
    'Clinical Psychologist',
    'Critical Care Specialist',
    'Dentist',
    'Dermatologist',
    'Emergency Medicine Specialist',
    'Endocrinologist',
    'ENT Specialist (Otolaryngologist)',
    'Family Medicine Physician',
    'Forensic Pathologist',
    'Gastroenterologist',
    'General Physician',
    'Geriatrician',
    'Gynecologist',
    'Hematologist',
    'Holistic Medicine Practitioner',
    'Hospitalist',
    'Hyperbaric Medicine Specialist',
    'Infectious Disease Specialist',
    'Integrative Medicine Specialist',
    'Maxillofacial Surgeon',
    'Medical Geneticist',
    'Neonatologist',
    'Nephrologist',
    'Neurologist',
    'Occupational Medicine Specialist',
    'Oncologist',
    'Ophthalmologist',
    'Orthopedic',
    'Pain Management Specialist',
    'Pathologist',
    'Pediatric Surgeon',
    'Pediatrician',
    'Physiotherapist',
    'Plastic Surgeon',
    'Podiatrist',
    'Pulmonologist',
    'Psychiatrist',
    'Radiologist',
    'Reproductive Endocrinologist',
    'Rheumatologist',
    'Sleep Medicine Specialist',
    'Sports Medicine Specialist',
    'Thoracic Surgeon',
    'Trauma Surgeon',
    'Transplant Surgeon',
    'Urologist',
    'Vascular Surgeon',
    'Veterinary Doctor'
  ];
}