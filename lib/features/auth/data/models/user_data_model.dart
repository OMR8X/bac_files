import 'package:bac_files_admin/features/auth/domain/entites/user_data.dart';

class UserDataModel extends UserData {
  UserDataModel({
    required super.name,
    required super.accountType,
    required super.email,
  });

  factory UserDataModel.fromJson(Map json) {
    print(json);
    return UserDataModel(
      name: json['name'],
      accountType: json['account_type'],
      email: json['email'],
    );
  }
  factory UserDataModel.fromEntity(UserData userData) {
    return UserDataModel(
      email: userData.email,
      accountType: userData.accountType,
      name: userData.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "account_type": accountType,
      "name": name,
    };
  }
}
