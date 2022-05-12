class MyUser {
  String id;
  String name;
  String serviceType;
  String email;
  String imagePath;
  String about;


  MyUser({
    this.id = '',
    this.serviceType = '',
    this.email = '',
    this.imagePath = '',
    this.about = '',
    required this.name,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'serviceType': serviceType,
    'email': email,
    'about': about,
    'imagePath': imagePath
  };
}

