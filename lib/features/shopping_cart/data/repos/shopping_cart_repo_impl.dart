import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:west_elbalad/core/functions/calculate_total_price.dart';
import 'package:west_elbalad/core/functions/get_user.dart';
import 'package:west_elbalad/features/shopping_cart/domian/entites/user_info_for_order_entities.dart';

import '../../../../core/constants/app_consts.dart';
import '../../../../core/errors/excptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/functions/generate_unique_id.dart';
import '../../../../core/functions/save_and_get_map_to_list_with_shared_pref.dart';
import '../../../home/data/model/phones_model.dart';
import '../../../home/domian/entites/phone_entites.dart';
import '../../domian/repos/shopping_cart.repo.dart';
import '../data_source/shopping_cart_remote_data_source.dart';
import '../model/user_info_for_order.dart';

class ShoppingCardRepoImpl extends ShoppingCartRepo {
  final ShoppingCartRemoteDataSource shoppingCartRemoteDataSource;

  ShoppingCardRepoImpl({required this.shoppingCartRemoteDataSource});

  @override
  Future<Either<Failure, void>> addOrder({
    required Map<String, dynamic> data,
  }) async {
    try {
      String documentId = generateUniqueId();
      List<Map<String, dynamic>> ordersData =
          await getListOfMapsFromSharedPref(kOrder);
      final List<PhoneEntites> orders = ordersData.map((ordersData) {
        return PhoneModel.fromMap(ordersData);
      }).toList();

      UserInfoForOrderEntities userInfoForOrderEntities =
          UserInfoForOrderEntities(
        id: documentId,
        authUserId: getUser().uId,
        authUserName: getUser().name,
        authUserEmail: getUser().email,
        userName: data["userName"].toLowerCase(),
        userPhone: data["userPhone"].toLowerCase(),
        userGovernorate: data["userGovernorate"].toLowerCase(),
        userLocation: data["userLocation"].toLowerCase(),
        lsitOfOrder: orders,
        totalPrice: calculateTotalPrice(orders),
      );
      await shoppingCartRemoteDataSource.addOrder(
          UserInfoForOrderModel.fromEntity(userInfoForOrderEntities).toMap(),
          documentId);

      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.addOrder: ${e.toString()}',
      );
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
    }
  }
}
