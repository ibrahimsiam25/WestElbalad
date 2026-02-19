import '../../domain/entites/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

class UserModel extends UserEntity {
  UserModel({required super.name, required super.email, required super.uId});

  factory UserModel.fromSupabaseUser(supa.User user, {String name = ''}) {
    return UserModel(
      name: name,
      email: user.email ?? '',
      uId: user.id,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      uId: json['uId'],
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      name: user.name,
      email: user.email,
      uId: user.uId,
    );
  }

  toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
    };
  }
}
