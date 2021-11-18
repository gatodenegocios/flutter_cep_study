import 'package:flutter_cep_study/core/error/exceptions.dart';
import 'package:flutter_cep_study/core/network/network_info.dart';
import 'package:flutter_cep_study/features/adress_by_cep/data/datasources/address_local_data_source.dart';
import 'package:flutter_cep_study/features/adress_by_cep/data/datasources/address_remote_data_source.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/entities/address.dart';
import 'package:flutter_cep_study/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/repositories/address_by_cep_repository.dart';

class AddressRepositoryImpl implements AddressByCepRepository {
  final AddressRemoteDataSource remoteDataSource;
  final AddressLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AddressRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Address>> getAddressByCep(String cep) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAddress = await remoteDataSource.getAddressByCep(cep);

        localDataSource.cacheAdress(remoteAddress);
        return Right(remoteAddress);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final remoteAddress = await localDataSource.getLastAdress();
        return Right(await localDataSource.getLastAdress());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
