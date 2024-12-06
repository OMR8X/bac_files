import 'package:bac_files_admin/features/auth/domain/entites/user_data.dart';

class UserDataModel extends UserData {
  UserDataModel({
    required super.name,
    required super.email,
  });

  factory UserDataModel.fromJson(Map json) {
    return UserDataModel(
      name: json['name'],
      email: json['email'],
    );
  }
  factory UserDataModel.fromEntity(UserData userData) {
    return UserDataModel(
      email: userData.email,
      name: userData.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
    };
  }
}
