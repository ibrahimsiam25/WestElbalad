import 'dart:convert';
import '../constants/app_consts.dart';
import '../service/shared_preferences_singleton.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/domain/entites/user_entity.dart';




UserEntity getUser() {
  var jsonString = SharedPref.getString(kUserInformationsSharPref);
  var userEntity = UserModel.fromJson(jsonDecode(jsonString));
  return userEntity;
}
