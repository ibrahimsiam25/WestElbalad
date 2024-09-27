import '../../features/home/domian/entites/phone_entites.dart';

int calculateTotalPrice(List<PhoneEntites> phoneList) {
  int totalPrice = 0;
  for (var phone in phoneList) {
    totalPrice += phone.price;
  }
  return totalPrice;
}