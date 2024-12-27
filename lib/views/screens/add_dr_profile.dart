import 'dart:developer';
import 'dart:io';
import 'package:cc_dr_side/functions/upload_image_s3bucket.dart';
import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/views/screens/select_available_days.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class AddDrProfile extends StatefulWidget {
  @override
  _AddDrProfileState createState() => _AddDrProfileState();
}

class _AddDrProfileState extends State<AddDrProfile> {
  Doctor? doctor;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController AgeController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController yearsOfExperienceController =
      TextEditingController();
  final TextEditingController consultationFeeController =
      TextEditingController();
  final TextEditingController locationController = TextEditingController();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
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
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage:
                                _image != null ? FileImage(_image!) : null,
                            child: _image == null
                                ? Icon(
                                    Icons.person,
                                    size: 80,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(0xFF4A78FF),
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    _buildTextField(fullNameController, 'Full Name',
                        'Enter your full name',
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words),
                    SizedBox(height: 20),
                    _buildTextField(hospitalNameController, 'Hospital Name',
                        'Enter your hospital name',
                        textCapitalization: TextCapitalization.words),
                    SizedBox(height: 20),
                    _buildTextField(AgeController, 'Age', 'Enter your Age',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ]),
                    SizedBox(height: 20),
                    _buildDropdownField(genderController, 'Gender',
                        'Select your gender', ['Male', 'Female']),
                    SizedBox(height: 20),
                    _buildDropdownField(categoryController, 'Category',
                        'Select your category', [
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
                    ]),
                    SizedBox(height: 20),
                    _buildTextField(yearsOfExperienceController,
                        'Years of Experience', 'Enter your years of experience',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ]),
                    SizedBox(height: 20),
                    _buildTextField(consultationFeeController,
                        'Consultation Fee', 'Enter your consultation fee',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ]),
                    SizedBox(height: 20),
                    _buildTextField(
                        locationController, 'Location', 'Enter your location',
                        textCapitalization: TextCapitalization.words),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () async {
                if (_image == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please add an image'),
                    backgroundColor: Colors.red,
                  ));
                } else {
                  if (_formKey.currentState?.validate() ?? false) {
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
                          image: profileUrl ?? '',
                          fullName: fullNameController.text,
                          age: AgeController.text,
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
                          availableDays: []);

                      Navigator.pop(context);

                      Get.to(
                        () => DayPage(
                          doctor: doctorModel,
                        ),
                        transition: Transition.rightToLeftWithFade,
                      );
                    } catch (error) {
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('An error occurred: $error'),
                        backgroundColor: Colors.red,
                      ));
                    }
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: Color(0xFF4A78FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                "Next",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, String hintText,
      {TextInputType keyboardType = TextInputType.text,
      List<TextInputFormatter>? inputFormatters,
      TextCapitalization textCapitalization = TextCapitalization.none}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,  // Ensure text is capitalized
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField(TextEditingController controller, String labelText,
      String hintText, List<String> items) {
    return DropdownButtonFormField<String>(
      value: controller.text.isEmpty ? null : controller.text,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
      ),
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          controller.text = value!;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your $labelText';
        }
        return null;
      },
    );
  }
}
 