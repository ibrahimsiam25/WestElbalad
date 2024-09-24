import 'package:hive/hive.dart';
part 'user_informations_entites.g.dart';

@HiveType(typeId: 0)
class UserInformationsEntity {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String uId;

  UserInformationsEntity({
    required this.name,
    required this.email,
    required this.uId,
  });
}
