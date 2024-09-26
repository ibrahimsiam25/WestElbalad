class UsedPhonesEntities {
  final String id;
  final String type;
  final String name;
  final String description;
  final int price;
  final String userName;
  final String userPhone;
  final String userGovernorate;
  final String userLocation;
  final String imageUrl;

  UsedPhonesEntities({
    required this.id,
    required this.type,
    required this.userGovernorate,
    required this.name,
    required this.description,
    required this.price,
    required this.userName,
    required this.userPhone,
    required this.userLocation,
    required this.imageUrl,
  });
}
