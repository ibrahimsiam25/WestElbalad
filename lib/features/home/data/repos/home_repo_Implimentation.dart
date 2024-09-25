import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:west_elbalad/core/errors/failure.dart';
import 'package:west_elbalad/core/errors/excptions.dart';
import 'package:west_elbalad/features/home/domian/repos/home_repo.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';
import 'package:west_elbalad/features/home/data/data_source/home_remote_data_source.dart';

class HomeRepoImplimentation extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImplimentation(
      {required this.homeRemoteDataSource});
  @override
  Future<Either<Failure, List<PhoneEntites>>> fetchPhonesData(
     ) async {
    List<PhoneEntites> phonesData;
    try {
    phonesData = await homeRemoteDataSource.fetchPhonesData();
        return right(phonesData);
      
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.fetchAllPhones: ${e.toString()}',
      );
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
    }
  }
  
  @override
  Future<Either<Failure, List<String>>> fetchOffersImagesUrl()async{
    try {
      List<String> imageUrls = await homeRemoteDataSource.fetchOffersImagesUrl();
      return right(imageUrls);
    }on CustomException catch (e) {
      return left(ServerFailure(e.message));
    }catch (e) {
      log(
        'Exception in AuthRepoImpl.fetchAllOffersImages: ${e.toString()}',
      );
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
    }
  }
}
