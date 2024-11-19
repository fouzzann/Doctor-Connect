import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class DrDetailsCollect extends StatefulWidget {
  @override
  _DrDetailsCollectState createState() => _DrDetailsCollectState();
}

class _DrDetailsCollectState extends State<DrDetailsCollect> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController yearsOfExperienceController = TextEditingController();
  final TextEditingController consultationFeeController = TextEditingController();

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
        title: Text(
          "Profile Page",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile Picture
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage:
                                _image != null ? FileImage(_image!) : null,
                            child: _image == null
                                ? Icon(
                                    Icons.person,
                                    size: 60,
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
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),

                    // Profile Form Fields
                    TextFormField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: hospitalNameController,
                      decoration: InputDecoration(
                        hintText: 'Hospital Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your hospital name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: dobController,
                      decoration: InputDecoration(
                        hintText: 'Date of Birth',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your date of birth';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // Gender Dropdown
                    DropdownButtonFormField<String>(
                      value: genderController.text.isEmpty
                          ? null
                          : genderController.text,
                      decoration: InputDecoration(
                        hintText: 'Gender',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      items: ['Male', 'Female']
                          .map((gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          genderController.text = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // Category Dropdown
                    DropdownButtonFormField<String>(
                      value: categoryController.text.isEmpty
                          ? null
                          : categoryController.text,
                      decoration: InputDecoration(
                        hintText: 'Category',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      items: [
                        'General',
                        'Cardiologist',
                        'Dermatologist',
                        'Pediatrician',
                        'Orthopedic',
                        'Gynecologist',
                        'Neurologist',
                        'Psychiatrist',
                        'Dentist',
                        'Ophthalmologist',
                        'Endocrinologist',
                        'Gastroenterologist',
                        'Oncologist',
                        'Urologist'
                      ]
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          categoryController.text = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your category';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // Years of Experience (2 digits only)
                    TextFormField(
                      controller: yearsOfExperienceController,
                      decoration: InputDecoration(
                        hintText: 'Years of Experience',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Only digits allowed
                        LengthLimitingTextInputFormatter(
                            2), // Limit to 2 digits
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your years of experience';
                        } else if (value.length != 2) {
                          return 'Please enter exactly 2 digits';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // Consultation Fee (10 digits only)
                    TextFormField(
                      controller: consultationFeeController,
                      decoration: InputDecoration(
                        hintText: 'Consultation Fee',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Only digits allowed
                        LengthLimitingTextInputFormatter(
                            10), // Limit to 10 digits
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the consultation fee';
                        } else if (value.length > 10) {
                          return 'Please enter up to 10 digits';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            // Save Button
            Container(
              width: 350,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Proceed if the form is valid
                    final imageUrl = _image != null ? 'some_url' : '';
                    // Save the details and navigate to next page
                    // Get.to(() => HomePage(url: imageUrl));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4A78FF),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
