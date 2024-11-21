import 'dart:developer';

import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/screens/add_certificate_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DayPage extends StatefulWidget {
  const DayPage({super.key,required this.doctor});
final Doctor doctor;
  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  final Set<int> selectedDays = {};
Doctor? doctor;
  final List<String> weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
@override
  void initState() {
   
    // TODO: implement initState
    super.initState();
  }
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white,
        title: const Text(
          "Select your available day's",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Center(
                child: SizedBox(
                  height: 300,
                  child: Image(
                    image: AssetImage(
                        'assets/pngtree-presentation-marketing-planning-cartoon-vector-illustration-picture-image_8444460.png'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: weekDays.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedDays.contains(index);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedDays.remove(index);
                          } else {
                            selectedDays.add(index);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                          border: isSelected
                              ? Border.all(color: Colors.blue, width: 2)
                              : null,
                        ),
                        child: Stack(
                          children: [
                            if (isSelected)
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 4,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            Center(
                              child: Text(
                                weekDays[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected ? Colors.blue : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                selectedDays.isNotEmpty
                    ? 'Selected days: ${selectedDays.map((index) => weekDays[index]).join(":")}'
                    : 'No days selected',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    List<String>selected=[];
                    for(var n in selectedDays){
                      selected.add(weekDays[n]);
                    }
                   
                  doctor=  Doctor.fromMap({ 'image': "image",
                    'fullName': widget.doctor.fullName,
                    'age':widget.doctor.age,
                    'email': '',
                    'gender': widget.doctor.gender,
                    'uid': '',
                    'category':widget.doctor.category,
                    'hospitalName': widget.doctor.hospitalName,
                    'location': '',
                    'isAccepted': false,
                    'docId': '',
                    'consultationFee': widget.doctor.consultationFee ,
                    'yearsOfExperience':widget.doctor.yearsOfExperience,
                    'certificateImage': '',
                    "availableDays":selected}
                    ); 
                  
                    log("hey${doctor!.availableDays}");
                     Get.to(() => AddCertificateImage(doctor: doctor,));
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
        ),
      ),
    );
  }

  List<String> getSelectedDays() {
    return selectedDays.map((index) => weekDays[index]).toList();
  }
}