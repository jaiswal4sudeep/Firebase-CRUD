class UserModel {
  String? avatar;
  String? name;
  String? email;

  UserModel({this.avatar, this.name, this.email});

  //fetch data from the server
  factory UserModel.fromMap(map) {
    return UserModel(
      avatar: map['avatar'],
      name: map['name'],
      email: map['email'],
    );
  }

  //save the data in the firestore
  Map<String, dynamic> toMap() {
    return {
      'avatar': avatar,
      'name': name,
      'email': email,
    };
  }
}
