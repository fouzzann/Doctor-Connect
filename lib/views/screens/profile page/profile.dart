import 'package:cc_dr_side/views/widgets/home/profile/profile_actions.dart';
import 'package:cc_dr_side/views/widgets/home/profile/profile_header.dart';
import 'package:cc_dr_side/views/widgets/home/profile/profile_menu_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cc_dr_side/controllers/doctore_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final DoctorController doctorController = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                buildProfileHeader(context),
                const SizedBox(height: 20),
                buildProfileActions(),
                const SizedBox(height: 20),
                buildProfileMenuSection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 100,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      title: Text(
        'Profile',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.settings, color: Colors.black54),
          onPressed: () {},
        ),
      ],
    );
  }
}
