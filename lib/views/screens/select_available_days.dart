import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cc_dr_side/model/dr_model.dart';
import 'package:cc_dr_side/views/screens/add_certificate_image.dart';

class DayPage extends StatefulWidget {
  const DayPage({super.key, required this.doctor});

  final Doctor doctor;
  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  bool isLoading = false;
  final Set<int> selectedDays = {};
  final List<String> weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child:
                Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Schedule Setup",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              "Choose your working days",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Progress Indicator
          LinearProgressIndicator(
            value: 0.7,
            backgroundColor: Colors.grey[100],
            valueColor: AlwaysStoppedAnimation<Color>(
              Color(0xFF4A78FF),
            ),
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

                // Days Grid
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.4,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
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
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue.shade50
                                  : Colors.grey[50],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? Color(0xFF4A78FF)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Stack(
                              children: [
                                if (isSelected)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF4A78FF),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.check,
                                          color: Colors.white, size: 12),
                                    ),
                                  ),
                                Center(
                                  child: Text(
                                    weekDays[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? Color(0xFF4A78FF)
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: weekDays.length,
                    ),
                  ),
                ),

                // Selected Days Summary
                if (selectedDays.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.all(24),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selected Days',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4A78FF),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: selectedDays.map((index) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      Border.all(color: Colors.blue.shade200),
                                ),
                                child: Text(
                                  weekDays[index],
                                  style: TextStyle(
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: selectedDays.isEmpty
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                            });

                            await Future.delayed(Duration(seconds: 2));

                            List<String> selected =
                                selectedDays.map((n) => weekDays[n]).toList();
                            final doctorModel = Doctor(
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
                              yearsOfExperience:
                                  widget.doctor.yearsOfExperience,
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
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4A78FF),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[300],
                      elevation: 0,
                      minimumSize: Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Next",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
