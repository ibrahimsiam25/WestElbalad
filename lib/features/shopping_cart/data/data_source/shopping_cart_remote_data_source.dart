import '../../../../core/service/data_service.dart';
import '../../../../core/utils/backend_endpoints.dart';


abstract class ShoppingCartRemoteDataSource {

  Future<void> addOrder({required String docId,required Map<String, dynamic> data,});
}

class ShoppingCartRemoteDataSourceImpl  extends ShoppingCartRemoteDataSource  {
  final DatabaseService databaseService;
  ShoppingCartRemoteDataSourceImpl({required this.databaseService});
 
  @override
  Future<void> addOrder({required String docId,required Map<String, dynamic> data,}) async {
    await databaseService.addDataInSubCollection(collection: BackendEndpoint.getUsersData, docId: docId, subCollection: BackendEndpoint.orders, data: data);
  }
}
