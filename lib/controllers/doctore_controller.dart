import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DoctorController extends GetxController {
  var doctorName = 'Dr. Unknown'.obs;
  var doctorImage = ''.obs;
  var doctorCategory = ''.obs;
  var userEmail = ''.obs;

  var isLoading = false.obs;
  var hasError = false.obs;
  var selectedTabIndex = 0.obs;

  Future<void> fetchDoctorData() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        userEmail.value = currentUser.email ?? '';

        final querySnapshot = await FirebaseFirestore.instance
            .collection('doctors')
            .where('email', isEqualTo: userEmail.value)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final doctorData = querySnapshot.docs.first.data();
          print('Doctor data fetched: $doctorData');
          doctorName.value = doctorData['fullName'] ?? 'Dr. Unknown';
          doctorImage.value = doctorData['image'] ?? '';
          doctorCategory.value = doctorData['category'] ?? '';
        } else {
          print('No doctor found with the email: ${userEmail.value}');
        }
      } else {
        print('No user is currently logged in');
      }
    } catch (e) {
      hasError.value = true;
      print('Error fetching doctor data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
