import 'package:dartz/dartz.dart';
import 'package:west_elbalad/core/errors/failure.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<PhoneEntites>>> fetchPhonesData();
}
