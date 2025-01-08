import 'dart:developer';
import 'dart:io';
import 'package:cc_dr_side/functions/upload_image_s3bucket.dart';
import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/views/screens/docter_add/select_available_days.dart';
import 'package:cc_dr_side/views/widgets/doctor_add/dr_add_page/add_dr_form.dart';
import 'package:cc_dr_side/views/widgets/doctor_add/dr_add_page/profile_image_section.dart';
import 'package:cc_dr_side/views/widgets/doctor_add/dr_add_page/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddDoctorProfilePage extends StatefulWidget {
  @override
  _AddDoctorProfilePageState createState() => _AddDoctorProfilePageState();
}

class _AddDoctorProfilePageState extends State<AddDoctorProfilePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController yearsOfExperienceController = TextEditingController();
  final TextEditingController consultationFeeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _handleSubmit() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please add an image'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!(_formKey.currentState?.validate() ?? false)) return;

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
      final String? profileUrl = await uploadImage(_image!);
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

      Navigator.pop(context);
      Get.to(
        () => DayPage(doctor: doctorModel),
        transition: Transition.rightToLeftWithFade,
      );
    } catch (error) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "Add Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    ProfileImageSection(
                      image: _image,
                      onPickImage: _pickImage,
                    ),
                    SizedBox(height: 30),
                    DoctorForm(
                      controllers: {
                        'fullName': fullNameController,
                        'hospitalName': hospitalNameController,
                        'age': ageController,
                        'gender': genderController,
                        'category': categoryController,
                        'yearsOfExperience': yearsOfExperienceController,
                        'consultationFee': consultationFeeController,
                        'location': locationController,
                        'mobileNumber': mobileNumberController,
                      },
                    ),
                  ],
                ), 
              ),
            ),
          ),
          SubmitButton(onSubmit: _handleSubmit),
        ],
      ),
    );
  }
}






