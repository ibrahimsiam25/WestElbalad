import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';

class PhoneModel extends PhoneEntites {
  PhoneModel(
      {required super.id,
        required super.type,
      required super.name,
      required super.description,
      required super.price,
      required super.imageUrl});
  factory PhoneModel.fromEntity(PhoneEntites user) {
    return PhoneModel(
      id: user.id,
      type: user.type,
      name: user.name,
      description: user.description,
      price: user.price,
      imageUrl: user.imageUrl,
    );
  }
factory PhoneModel.fromMap(Map<String, dynamic> map) {
  return PhoneModel(
    id: map['id'],
    type: map['type'],
    name: map['name'],
    description: map['description'],
    price: map['price'],
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
      'imageUrl': imageUrl
    };
  }
}


