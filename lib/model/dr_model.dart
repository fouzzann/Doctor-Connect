class Doctor {
  final String image;
  final String fullName;
  final String age;
  final String email;
  final String gender;
  final String uid;
  final String category;
  final String hospitalName;
  final String location;
  final bool isAccepted;
  final String? docId;
  final String consultationFee;
  final String yearsOfExperience;
  final String certificateImage;
  final List<String> availableDays;
  final String contact;
   String? rating; 
  List<int>? ratingList;

  Doctor(
      {required this.image,
      required this.fullName,
      required this.age,
      required this.email,
      required this.gender,
      required this.uid,
      required this.category,
      required this.hospitalName,
      required this.location,
      required this.isAccepted,
      this.docId,
      required this.consultationFee,
      required this.yearsOfExperience,
      required this.certificateImage,
      required this.availableDays,
      required this.contact,
      this.ratingList,
      this.rating
      });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'fullName': fullName,
      'age': age,
      'email': email,
      'gender': gender,
      'uid': uid,
      'category': category,
      'hospitalName': hospitalName,
      'location': location,
      'isAccepted': isAccepted,
      'docId': docId,
      'consultationFee': consultationFee,
      'yearsOfExperience': yearsOfExperience,
      'certificateImage': certificateImage,
      'availableDays': availableDays,
      'rating': rating,
      'contact': contact,
      'ratingList': ratingList,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
        image: map['image'] ?? '',
        fullName: map['fullName'] ?? '',
        age: map['age'] ?? 0,
        email: map['email'] ?? '',
        gender: map['gender'] ?? '',
        uid: map['uid'] ?? '',
        category: map['category'] ?? '',
        hospitalName: map['hospitalName'] ?? '',
        location: map['location'] ?? '',
        isAccepted: map['isAccepted'] ?? false,
        docId: map['docId'],
        consultationFee: map['consultationFee']?.toDouble() ?? 0.0,
        yearsOfExperience: map['yearsOfExperience'] ?? 0,
        certificateImage: map['certificateImage'] ?? '',
        availableDays: List<String>.from(map['availableDays']),
        rating: map['rating'] ?? '0.0',
         ratingList: List<int>.from(map['ratingList'] ?? []),
        contact: map['contact'] ?? '');
        
  }
}
 