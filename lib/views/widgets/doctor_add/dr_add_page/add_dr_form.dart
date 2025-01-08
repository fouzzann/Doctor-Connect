import 'package:cc_dr_side/views/widgets/doctor_add/dr_add_page/custom_drop_down_filed.dart';
import 'package:cc_dr_side/views/widgets/doctor_add/dr_add_page/custom_text_filed.dart';
import 'package:cc_dr_side/views/widgets/doctor_add/dr_add_page/dr_categories_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoctorForm extends StatelessWidget {
  final Map<String, TextEditingController> controllers;

  const DoctorForm({
    Key? key,
    required this.controllers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: controllers['fullName']!,
          labelText: 'Full Name',
          hintText: 'Enter your full name',
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: controllers['hospitalName']!,
          labelText: 'Hospital Name',
          hintText: 'Enter your hospital name',
          textCapitalization: TextCapitalization.words,
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: controllers['age']!,
          labelText: 'Age',
          hintText: 'Enter your Age',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3),
          ],
        ),
        SizedBox(height: 20),
        CustomDropdownField(
          controller: controllers['gender']!,
          labelText: 'Gender',
          hintText: 'Select your gender',
          items: ['Male', 'Female'],
          onChanged: (value) {
            controllers['gender']!.text = value!;
          },
        ),
        SizedBox(height: 20),
        CustomDropdownField(
          controller: controllers['category']!,
          labelText: 'Category',
          hintText: 'Select your category',
          items: DoctorCategories.categories,
          onChanged: (value) {
            controllers['category']!.text = value!;
          },
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: controllers['yearsOfExperience']!,
          labelText: 'Years of Experience',
          hintText: 'Enter your years of experience',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: controllers['consultationFee']!,
          labelText: 'Consultation Fee',
          hintText: 'Enter your consultation fee',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: controllers['location']!,
          labelText: 'Location',
          hintText: 'Enter your location',
          textCapitalization: TextCapitalization.words,
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: controllers['mobileNumber']!,
          labelText: 'Mobile Number',
          hintText: 'Enter your mobile number',
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your mobile number';
            }
            if (value.length != 10) {
              return 'Mobile number must be 10 digits';
            }
            return null;
          },
        ),
      ],
    );
  }
}
