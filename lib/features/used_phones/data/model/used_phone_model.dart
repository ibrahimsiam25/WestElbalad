import '../../domian/entities/used_phone_entities.dart';

class UsedPhoneModel extends UsedPhonesEntities {
  UsedPhoneModel(
      {required super.id,
      required super.type,
      required super.name,
      required super.description,
      required super.price,
      required super.userName,
      required super.userPhone,
      required super.userGovernorate,
      required super.userLocation,
      required super.imageUrl});
  factory UsedPhoneModel.fromEntity(UsedPhonesEntities user) {
    return UsedPhoneModel(
      id: user.id,
      type: user.type,
      name: user.name,
      description: user.description,
      price: user.price,
      userName: user.userName,
      userPhone: user.userPhone,
      userLocation: user.userLocation,
      userGovernorate: user.userGovernorate,
      imageUrl: user.imageUrl,
    );
  }
  factory UsedPhoneModel.fromMap(Map<String, dynamic> map) {
    return UsedPhoneModel(
      id: map['id'],
      type: map['type'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      userName: map['userName'],
      userPhone: map['userPhone'],
      userGovernorate: map['userGovernorate'],
      userLocation: map['userLocation'],
      imageUrl: map['imageUrl'],
    );
  }
  toMap() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'description': description,
      'price': price,
      'userName': userName,
      'userPhone': userPhone,
      'userLocation': userLocation,
      'userGovernorate': userGovernorate,
      'imageUrl': imageUrl
    };
  }
}
