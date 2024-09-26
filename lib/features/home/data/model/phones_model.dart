import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';

class PhoneModel extends PhoneEntites {
  PhoneModel(
      {required super.id,
      required super.type,
      required super.status,
      required super.name,
      required super.description,
      required super.price,
      required super.userName,
      required super.userPhone,
      required super.userLocation,
      required super.imageUrl});
  factory PhoneModel.fromEntity(PhoneEntites user) {
    return PhoneModel(
      id: user.id,
      type: user.type,
      status: user.status,
      name: user.name,
      description: user.description,
      price: user.price,
      userName: user.userName,
      userPhone: user.userPhone,
      userLocation: user.userLocation,
      imageUrl: user.imageUrl,
    );
  }
  factory PhoneModel.fromMap(Map<String, dynamic> map) {
    return PhoneModel(
      id: map['id'],
      type: map['type'],
      status: map['status'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      userName: map['userName'],
      userPhone: map['userPhone'],
      userLocation: map['userLocation'],
      imageUrl: map['imageUrl'],
    );
  }
  toMap() {
    return {
      'id': id,
      'type': type,
      'status': status,
      'name': name,
      'description': description,
      'price': price,
      'userName': userName,
      'userPhone': userPhone,
      'userLocation': userLocation,
      'imageUrl': imageUrl
    };
  }
}
