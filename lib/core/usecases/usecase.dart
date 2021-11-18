import 'package:dartz/dartz.dart';
import 'package:flutter_cep_study/core/error/failures.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/entities/address.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
