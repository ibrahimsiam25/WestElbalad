import '../../../home/data/model/phones_model.dart';
import '../../domian/entites/user_info_for_order_entities.dart';

class UserInfoForOrderModel extends UserInfoForOrderEntities {
  UserInfoForOrderModel({
    required super.id,
    required super.authUserId,
    required super.authUserName,
    required super.authUserEmail,
    required super.totalPrice,
    required super.userGovernorate,
    required super.userName,
    required super.userPhone,
    required super.userLocation,
    required super.lsitOfOrder,
  });
  factory UserInfoForOrderModel.fromEntity(UserInfoForOrderEntities user) {
    return UserInfoForOrderModel(
      id: user.id,
      authUserId: user.authUserId,
      authUserName: user.authUserName,
      authUserEmail: user.authUserEmail,
      totalPrice: user.totalPrice,
      userName: user.userName,
      userPhone: user.userPhone,
      userLocation: user.userLocation,
      userGovernorate: user.userGovernorate,
      lsitOfOrder: user.lsitOfOrder,
    );
  }
  factory UserInfoForOrderModel.fromMap(Map<String, dynamic> map) {
    return UserInfoForOrderModel(
      id: map['id'],
      authUserId: map['authUserId'],
      authUserName: map['authUserName'],
      authUserEmail: map['authUserEmail'],
      totalPrice: map['totalPrice'],
      userName: map['userName'],
      userPhone: map['userPhone'],
      userGovernorate: map['userGovernorate'],
      userLocation: map['userLocation'],
      lsitOfOrder: map['lsitOfOrder'],
    );
  }
  toMap() {
    return {
      'id': id,
      'authUserId': authUserId,
      'authUserName': authUserName,
      'authUserEmail': authUserEmail,
      'totalPrice': totalPrice,
      'userName': userName,
      'userPhone': userPhone,
      'userLocation': userLocation,
      'userGovernorate': userGovernorate,
      'lsitOfOrder':
          lsitOfOrder.map((phone) => (phone as PhoneModel).toMap()).toList(),
    };
  }
}
