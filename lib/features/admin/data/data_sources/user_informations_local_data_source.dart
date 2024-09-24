import '../../../../core/constants/app_consts.dart';
import '../../../../core/service/hive_service.dart';
import '../../domain/entities/user_informations_entites.dart';

abstract class UserInformationsLocalDataSource {
  Future<List<UserInformationsEntity>> fetchUsersData();
}

class UserInformationsLocalDataSourceImpl extends UserInformationsLocalDataSource {
  @override
  Future<List<UserInformationsEntity>> fetchUsersData() async {
    var box = await openBox<UserInformationsEntity>(kUserInformationsHive);
    return box.values.toList();
  }
}