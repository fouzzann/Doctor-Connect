import 'dart:developer';
import 'dart:io';

import 'package:cc_dr_side/functions/upload_image_s3bucket.dart';
import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/views/screens/is_accepted_by_the_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DrEditScreen extends StatefulWidget {
  DrEditScreen({
    super.key,
    required this.doctor,
  });
  final Doctor doctor;
  @override
  State<DrEditScreen> createState() => _DrEditScreenState();
}

class _DrEditScreenState extends State<DrEditScreen> {
  final _formKey = GlobalKey<FormState>();
  String? drImagePath;
  String? _certificateImagePath;
  final Color primaryColor = const Color(0xFF4A78FF);
  late TextEditingController fullNameController;
  late TextEditingController hospitalNameController;
  late TextEditingController AgeController;
  late TextEditingController genderController;
  late TextEditingController categoryController;
  late TextEditingController yearsOfExperienceController;
  late TextEditingController consultationFeeController;
  late TextEditingController locationController;
  late TextEditingController availableDaysController;

  final List<String> weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
  List<String> selectedDays = [];

  @override
  void initState() {
    log(widget.doctor.image);
    fullNameController = TextEditingController(text: widget.doctor.fullName);
    AgeController = TextEditingController(text: widget.doctor.age);
    yearsOfExperienceController =
        TextEditingController(text: widget.doctor.yearsOfExperience);
    hospitalNameController =
        TextEditingController(text: widget.doctor.hospitalName);
    consultationFeeController =
        TextEditingController(text: widget.doctor.consultationFee);
    availableDaysController = TextEditingController(
        text: widget.doctor.availableDays.toList().toString());
    locationController = TextEditingController(text: widget.doctor.location);

    selectedDays = List<String>.from(widget.doctor.availableDays);
    super.initState();
  }

  void _updateAvailableDays() {
    availableDaysController.text = selectedDays.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                        radius: 60,
                        backgroundImage: drImagePath == null
                            ? NetworkImage(widget.doctor.image)
                            : FileImage(File(drImagePath!)) as ImageProvider),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: primaryColor,
                        child: IconButton(
                          icon: const Icon(Icons.add_a_photo,
                              color: Colors.white),
                          onPressed: () async {
                            final pickedImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (pickedImage != null) {
                              setState(() {
                                drImagePath = pickedImage.path;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medical Certificate',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () async {
                          final pickedImage = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (pickedImage != null) {
                            setState(() {
                              _certificateImagePath = pickedImage.path;
                            });
                          }
                        },
                        child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: primaryColor.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: _certificateImagePath == null
                                ? Image.network(widget.doctor.certificateImage)
                                : Image.file(File(_certificateImagePath!))),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  prefixIcon: Icon(Icons.person, color: primaryColor),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: AgeController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  prefixIcon: Icon(Icons.calendar_today, color: primaryColor),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: yearsOfExperienceController,
                decoration: InputDecoration(
                  labelText: 'Years of Experience',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  prefixIcon: Icon(Icons.work_history, color: primaryColor),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter years of experience';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: hospitalNameController,
                decoration: InputDecoration(
                  labelText: 'Hospital Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  prefixIcon: Icon(Icons.local_hospital, color: primaryColor),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter hospital name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: consultationFeeController,
                decoration: InputDecoration(
                  labelText: 'Consultation Fee',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  prefixIcon: Icon(Icons.attach_money, color: primaryColor),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter consultation fee';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  prefixIcon: Icon(Icons.location_on, color: primaryColor),
                ),
                validator: (value) { 
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Select Your Available Days',
                style: TextStyle( 
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: weekDays.map((day) {
                  final isSelected = selectedDays.contains(day);
                  return FilterChip(
                    label: Text(
                      day,
                      style: TextStyle(
                        color: isSelected ? Colors.white : primaryColor,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedDays.add(day);
                        } else {
                          selectedDays.remove(day);
                        }
                        _updateAvailableDays();
                      });
                    },
                    selectedColor: primaryColor,
                    checkmarkColor: Colors.white,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: primaryColor),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: availableDaysController,
                decoration: InputDecoration(
                  labelText: 'Selected Days',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  prefixIcon: Icon(Icons.calendar_today, color: primaryColor),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    final doctorImageUrl = drImagePath != null
                        ? await uploadImage(File(drImagePath!))
                        : widget.doctor.image;
                    final certificateImageUrl = _certificateImagePath != null
                        ? await uploadImage(File(_certificateImagePath!))
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
                      'availableDays': selectedDays
                    });
                    Get.offAll(() => IsAcceptedByTheAdmin());
                  },
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
          ),
        ),
      ), 
    );
  }
}
