import '../../domain/entites/user_data.dart';
import '../models/user_data_model.dart';

extension UserDataMapper on UserData {
  UserDataModel get toModel {
    return UserDataModel(
      name: name,
      accountType: accountType,
      email: email,
    );
  }
}

extension UserDataModelMapper on UserDataModel {
  UserData get toEntity {
    return UserData(
      name: name,
      accountType: accountType,
      email: email,
    );
  }
}
