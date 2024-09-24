import 'package:west_elbalad/features/admin/domain/entities/user_informations_entites.dart';

class UserInformationsModel extends UserInformationsEntity {
  UserInformationsModel({
    required super.name,
    required super.email,
    required super.uId,
  });
  factory UserInformationsModel.fromMap(
      Map<String, dynamic> data) {
    return UserInformationsModel(
      uId: data['uId'] ?? 'Unknown',
      name: data['name'] ?? 'Unknown',
      email: data['email'] ?? 'Unknown',
    );
  }
}
