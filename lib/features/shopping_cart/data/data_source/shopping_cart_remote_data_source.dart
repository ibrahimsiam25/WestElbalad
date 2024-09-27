import '../../../../core/service/data_service.dart';
import '../../../../core/utils/backend_endpoints.dart';


abstract class ShoppingCartRemoteDataSource {

  Future<void>addOrder(
      Map<String, dynamic> data, String documentId);
}

class ShoppingCartRemoteDataSourceImpl  extends ShoppingCartRemoteDataSource  {
  final DatabaseService databaseService;
  ShoppingCartRemoteDataSourceImpl({required this.databaseService});
 
  @override
  Future<void>  addOrder(
      Map<String, dynamic> data, String documentId) async {
    await databaseService.addData(
        documentId: documentId, path: BackendEndpoint.orders, data: data);
  }
}
