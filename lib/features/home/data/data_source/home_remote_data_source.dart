import '../../../../core/service/data_service.dart';
import '../../../../core/utils/backend_endpoints.dart';
import '../../domian/entites/phone_entites.dart';
import '../model/phones_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<PhoneEntites>> fetchPhonesData();
  Future<List<String>> fetchOffersImagesUrl();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final DatabaseService databaseService;
  HomeRemoteDataSourceImpl({required this.databaseService});
  @override
  Future<List<PhoneEntites>> fetchPhonesData() async {
    var phonesData =
        await databaseService.fetchAllDocuments(BackendEndpoint.newPhone);
    final List<PhoneEntites> phoneList = phonesData.map((data) {
      return PhoneModel.fromMap(data);
    }).toList();

    return phoneList;
  }

  @override
  Future<List<String>> fetchOffersImagesUrl() async {
    var offersData =
        await databaseService.fetchAllDocuments(BackendEndpoint.offers);
    List<String> imageUrls =
        offersData.map((offer) => offer['imageUrl'] as String).toList();
    return imageUrls;
  }
}
