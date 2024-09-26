abstract class ShoppingCartRepo {
  Future<void> addOrder({required String docId,required Map<String, dynamic> data,});
}