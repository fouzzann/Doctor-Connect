import 'dart:io';
import 'package:cc_dr_side/functions/upload_image_s3bucket.dart';
import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/views/screens/is_accepted_by_the_admin/is_accepted_by_the_admin.dart';
import 'package:cc_dr_side/views/widgets/doctor_edit/available_days_selecter.dart';
import 'package:cc_dr_side/views/widgets/doctor_edit/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrEditFormWidget extends StatefulWidget {
  const DrEditFormWidget({
    Key? key,
    required this.doctor,
    required this.drImagePath,
    required this.certificateImagePath,
  }) : super(key: key);

  final Doctor doctor;
  final String? drImagePath;
  final String? certificateImagePath;

  @override
  State<DrEditFormWidget> createState() => _DrEditFormWidgetState();
}

class _DrEditFormWidgetState extends State<DrEditFormWidget> {
  final Color primaryColor = const Color(0xFF4A78FF);
  late TextEditingController fullNameController;
  late TextEditingController hospitalNameController;
  late TextEditingController AgeController;
  late TextEditingController yearsOfExperienceController;
  late TextEditingController consultationFeeController;
  late TextEditingController locationController;
  late TextEditingController availableDaysController;
  late TextEditingController contactController;
  List<String> selectedDays = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    fullNameController = TextEditingController(text: widget.doctor.fullName);
    AgeController = TextEditingController(text: widget.doctor.age);
    yearsOfExperienceController = TextEditingController(text: widget.doctor.yearsOfExperience);
    hospitalNameController = TextEditingController(text: widget.doctor.hospitalName);
    consultationFeeController = TextEditingController(text: widget.doctor.consultationFee);
    locationController = TextEditingController(text: widget.doctor.location);
    selectedDays = List<String>.from(widget.doctor.availableDays);
    availableDaysController = TextEditingController(
        text: selectedDays.isEmpty ? '' : selectedDays.join(', '));
    contactController = TextEditingController(text: widget.doctor.contact);
  }

  void _updateAvailableDays(List<String> days) {
    setState(() {
      selectedDays = days;
      availableDaysController.text = days.isEmpty ? '' : days.join(', ');
    });
  }

  Future<void> _saveChanges() async {
    final doctorImageUrl = widget.drImagePath != null
        ? await uploadImage(File(widget.drImagePath!))
        : widget.doctor.image;
    final certificateImageUrl = widget.certificateImagePath != null
        ? await uploadImage(File(widget.certificateImagePath!))
        : widget.doctor.certificateImage;

    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(widget.doctor.email)
        .update({
      'yearsOfExperience': yearsOfExperienceController.text,
      'isAccepted': false,
      'hospitalName': hospitalNameController.text,
      'fullName': fullNameController.text,
      'certificateImage': certificateImageUrl,
      'age': AgeController.text,
      'image': doctorImageUrl,
      'location': locationController.text,
      'consultationFee': consultationFeeController.text,
      'availableDays': selectedDays,
      'contact': contactController.text
    });
    Get.offAll(() => IsAcceptedByTheAdmin());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomFormField(
          controller: fullNameController,
          labelText: 'Full Name',
          icon: Icons.person,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter your name' : null,
        ),
        const SizedBox(height: 16),
        CustomFormField(
          controller: AgeController,
          labelText: 'Age',
          icon: Icons.calendar_today,
          keyboardType: TextInputType.number,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter your age' : null,
        ),
        const SizedBox(height: 16),
        CustomFormField(
          controller: yearsOfExperienceController,
          labelText: 'Years of Experience',
          icon: Icons.work_history,
          keyboardType: TextInputType.number,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter years of experience' : null,
        ),
        const SizedBox(height: 16),
        CustomFormField(
          controller: hospitalNameController,
          labelText: 'Hospital Name',
          icon: Icons.local_hospital,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter hospital name' : null,
        ),
        const SizedBox(height: 16),
        CustomFormField(
          controller: consultationFeeController,
          labelText: 'Consultation Fee',
          icon: Icons.attach_money,
          keyboardType: TextInputType.number,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter consultation fee' : null,
        ),
        const SizedBox(height: 16),
        CustomFormField(
          controller: locationController,
          labelText: 'Location',
          icon: Icons.location_on,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter location' : null,
        ),
        const SizedBox(height: 16),
        CustomFormField(
          controller: contactController,
          labelText: 'Contact',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Please enter contact';
            if (value!.length != 10) {
              return 'Please enter a valid 10-digit contact number';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        CustomFormField(
          controller: availableDaysController,
          labelText: 'Selected Days',
          icon: Icons.calendar_today,
          readOnly: true,
        ),
        const SizedBox(height: 24),
        AvailableDaysSelector(
          selectedDays: selectedDays,
          onDaysChanged: _updateAvailableDays,
          primaryColor: primaryColor,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _saveChanges,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: const Text(
              'Save Changes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}




