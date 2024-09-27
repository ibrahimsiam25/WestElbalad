import '../../../home/domian/entites/phone_entites.dart';

class UserInfoForOrderEntities {
  final String id;

  final String authUserId;
  final String authUserName;
  final String authUserEmail;

  final int totalPrice;
  final String userName;
  final String userPhone;
  final String userGovernorate;
  final String userLocation;
  final List<PhoneEntites> lsitOfOrder; 

 UserInfoForOrderEntities({required this.lsitOfOrder, 
    required this.id,
    required this.authUserId,
    required this.authUserName,
    required this.authUserEmail,
    required this.totalPrice,
    required this.userGovernorate,

 
    required this.userName,
    required this.userPhone,
    required this.userLocation,
 
  });
}
 
