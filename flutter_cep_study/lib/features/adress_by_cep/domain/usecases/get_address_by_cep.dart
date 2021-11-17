import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cep_study/core/error/failures.dart';
import 'package:flutter_cep_study/core/usecases/usecase.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/entities/address.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/repositories/address_by_cep_repository.dart';

class GetAddressByCep implements UseCase<Address, Params> {
  final AddressByCepRepository repository;

  GetAddressByCep(this.repository);

  @override
  Future<Either<Failure, Address>> call(Params params) async {
    return await repository.getAddressByCep(params.cep);
  }
}

class Params extends Equatable {
  late final String cep;

  Params({required this.cep});

  @override
  List<Object> get props => [cep];
}
