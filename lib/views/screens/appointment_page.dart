import 'package:cc_dr_side/controllers/doctore_controller.dart';
import 'package:cc_dr_side/views/widgets/home/appoinments/tapbar.dart';
import 'package:cc_dr_side/views/widgets/home/appoinments/user_name_and_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentContent extends StatelessWidget {
  const AppointmentContent({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorController doctorController = Get.put(DoctorController());

    doctorController.fetchDoctorData();

    return Scaffold(
      body: Obx(() {
        if (doctorController.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: Color(0xFF4A78FF)));
        } else if (doctorController.hasError.value) {
          return const Center(child: Text('Failed to load data.'));
        }

        return Column(
          children: [
            UserNameAndImage(),
            const SizedBox(height: 54),
            TabBarWidget(
              selectedIndex: doctorController.selectedTabIndex.value,
              onTabTapped: (index) {
                doctorController.selectedTabIndex.value = index;
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: buildTabContent(doctorController.selectedTabIndex.value),
            ),
          ],
        );
      }),
    );
  }
}
