import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/views/screens/docter_add/add_certificate_image.dart';
import 'package:cc_dr_side/views/widgets/doctor_add/availble_days_slelecting_page/day_grid.dart';
import 'package:cc_dr_side/views/widgets/doctor_add/availble_days_slelecting_page/next_button.dart';
import 'package:cc_dr_side/views/widgets/doctor_add/availble_days_slelecting_page/schedule_app_bar.dart';
import 'package:cc_dr_side/views/widgets/doctor_add/availble_days_slelecting_page/select_days_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DayPage extends StatefulWidget {
  const DayPage({super.key, required this.doctor});

  final Doctor doctor;
  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  bool isLoading = false;
  final Set<int> selectedDays = {};
  final List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  void _handleDaySelection(int index) {
    setState(() {
      if (selectedDays.contains(index)) {
        selectedDays.remove(index);
      } else {
        selectedDays.add(index);
      }
    });
  }

  Future<void> _handleNext() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    List<String> selected = selectedDays.map((n) => weekDays[n]).toList();
    final doctorModel = Doctor(
      contact: widget.doctor.contact,
      image: widget.doctor.image,
      fullName: widget.doctor.fullName,
      age: widget.doctor.age,
      email: '',
      gender: widget.doctor.gender,
      uid: '',
      category: widget.doctor.category,
      hospitalName: widget.doctor.hospitalName,
      location: widget.doctor.location,
      isAccepted: false,
      consultationFee: widget.doctor.consultationFee,
      yearsOfExperience: widget.doctor.yearsOfExperience,
      certificateImage: '',
      availableDays: selected,
    );

    setState(() {
      isLoading = false;
    });

    Get.to(
      () => AddCertificateImage(doctor: doctorModel),
      transition: Transition.rightToLeftWithFade,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ScheduleAppBar(),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: 0.7,
            backgroundColor: Colors.grey[100],
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4A78FF)),
            minHeight: 2,
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 200,
                    margin: EdgeInsets.all(24),
                    child: Image.asset(
                      'assets/pngtree-presentation-marketing-planning-cartoon-vector-illustration-picture-image_8444460.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                DaysGrid(
                  weekDays: weekDays,
                  selectedDays: selectedDays,
                  onDaySelected: _handleDaySelection,
                ),
                if (selectedDays.isNotEmpty)
                  SelectedDaysSummary(
                    selectedDays: selectedDays,
                    weekDays: weekDays,
                  ),
              ],
            ),
          ),
          NextButton(
            isLoading: isLoading,
            enabled: selectedDays.isNotEmpty,
            onPressed: _handleNext,
          ),
        ],
      ),
    );
  }
}















