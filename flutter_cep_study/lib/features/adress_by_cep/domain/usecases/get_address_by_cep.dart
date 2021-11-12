import 'package:dartz/dartz.dart';
import 'package:flutter_cep_study/core/error/failures.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/entities/address.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/repositories/address_by_cep_repository.dart';

class GetAddressByCep {
  final AddressByCepRepository repository;

  GetAddressByCep(this.repository);

  Future<Either<Failure, Address>> execute({
    required String cep,
  }) async {
    return await repository.getAddressByCep(cep);
  }
}
