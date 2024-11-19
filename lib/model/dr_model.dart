class Doctor {
  final String image;
  final String fullName;
  final int age;
  final String dateOfBirth;
  final String email;
  final String gender;
  final String uid;
  final String category;
  final String hospitalName;
  final String location;
  final bool isAccepted;
  final String? docId;

  Doctor({
    required this.image,
    required this.fullName,
    required this.age,
    required this.dateOfBirth,
    required this.email,
    required this.gender,
    required this.uid,
    required this.category,
    required this.hospitalName,
    required this.location,
    required this.isAccepted,
    this.docId,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'fullName': fullName,
      'age': age,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'gender': gender,
      'uid': uid,
      'category': category,
      'hospitalName': hospitalName,
      'location': location,
      'isAccepted': isAccepted
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
        image: map['image'] ?? '',
        fullName: map['fullName'] ?? '',
        age: map['age'] ?? 0,
        dateOfBirth: map['dateOfBirth'] ?? '',
        email: map['email'] ?? '',
        gender: map['gender'] ?? '',
        uid: map['uid'] ?? '',
        category: map['category'] ?? '',
        hospitalName: map['hospitalName'] ?? '',
        location: map['location'] ?? '',
        isAccepted: map['isAccepted'] ?? '',
        docId:map['docId']??'',
        );
  }
}
