//Contract for the repository

import 'package:dartz/dartz.dart';
import 'package:flutter_cep_study/core/error/failures.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/entities/address.dart';

abstract class AddressByCepRepository {
  Future<Either<Failure, Address>> getAddressByCep(String cep);
}
