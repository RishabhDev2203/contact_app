class ContactDto {
  final int? id;
  final String name;
  final String phoneNumber;
  final String email;
  final String? imagePath;
  final bool isFavorite;

  ContactDto(
      {this.id,
      required this.name,
      required this.phoneNumber,
      required this.email,
      this.imagePath, this.isFavorite = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'imagePath': imagePath,
      'isFavorite': isFavorite ? 1 : 0
    };
  }

  factory ContactDto.fromMap(Map<String, dynamic> map) {
    return ContactDto(
        id: map['id'],
        name: map['name'],
        phoneNumber: map['phoneNumber'],
        email: map['email'],
        imagePath: map['imagePath'],
        isFavorite: map['isFavorite'] == 1);
  }
}
