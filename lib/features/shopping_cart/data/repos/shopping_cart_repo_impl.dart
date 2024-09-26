import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/excptions.dart';
import '../../domian/repos/shopping_cart.repo.dart';
import '../data_source/shopping_cart_remote_data_source.dart';



class ShoppingCardRepoImpl extends ShoppingCartRepo{
  final ShoppingCartRemoteDataSource shoppingCartRemoteDataSource;

  ShoppingCardRepoImpl({required this.shoppingCartRemoteDataSource});

  @override
  Future<Either<Failure, void>> addOrder({required String docId,required Map<String, dynamic> data,}) async{
   try {
  await    shoppingCartRemoteDataSource.addOrder( docId: docId , data: data);
    return right(null);
   }on CustomException catch (e) {
    return left(ServerFailure(e.message));
   }catch (e) {
    log(
      'Exception in AuthRepoImpl.addOrder: ${e.toString()}',
    );
    return left(
      ServerFailure(
        'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
      ),
    );
   }
  }
  }