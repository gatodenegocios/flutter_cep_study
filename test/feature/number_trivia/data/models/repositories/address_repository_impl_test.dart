import 'package:dartz/dartz.dart';
import 'package:flutter_cep_study/core/error/exceptions.dart';
import 'package:flutter_cep_study/core/error/failures.dart';
import 'package:flutter_cep_study/core/network/network_info.dart';
import 'package:flutter_cep_study/features/adress_by_cep/data/datasources/address_remote_data_source.dart';
import 'package:flutter_cep_study/features/adress_by_cep/data/datasources/address_local_data_source.dart';
import 'package:flutter_cep_study/features/adress_by_cep/data/models/address_model.dart';
import 'package:flutter_cep_study/features/adress_by_cep/data/repositories/adress_repository_impl.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'address_repository_impl_test.mocks.dart';

@GenerateMocks([AddressRemoteDataSource])
@GenerateMocks([AddressLocalDataSource])
@GenerateMocks([NetworkInfo])
void main() {
  late AddressRepositoryImpl repository;
  late MockAddressRemoteDataSource mockRemoteDataSource;
  late MockAddressLocalDataSource mockLocalDataSource;

  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockAddressRemoteDataSource();
    mockLocalDataSource = MockAddressLocalDataSource();

    mockNetworkInfo = MockNetworkInfo();

    repository = AddressRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getAddress', () {
    final tCep = "89010025";

    final tAddressModel = AddressModel(
      cep: 'test',
      city: 'test',
      neighborhood: 'test',
      state: 'test',
      street: 'test',
    );

    final tAddress = tAddressModel;

    test('should check if the device is online', () async {
      // arrange for
      when(mockRemoteDataSource.getAddressByCep(any))
          .thenAnswer((_) async => tAddressModel);
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getAddressByCep(tCep);
      // assert

      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is sucessful',
          () async {
        // arrange for

        when(mockRemoteDataSource.getAddressByCep(any))
            .thenAnswer((_) async => tAddressModel);

        // act
        final result = await repository.getAddressByCep(tCep);
        // assert

        verify(mockRemoteDataSource.getAddressByCep(tCep));
        expect(result, equals(Right(tAddress)));
      });

      test(
          'should return cache the data locally when the call to remote data source is sucessful',
          () async {
        // arrange for

        when(mockRemoteDataSource.getAddressByCep(any))
            .thenAnswer((_) async => tAddressModel);

        // act
        await repository.getAddressByCep(tCep);
        // assert

        verify(mockRemoteDataSource.getAddressByCep(tCep));
        verify(mockLocalDataSource.cacheAdress(tAddressModel));
      });

      test(
          'should return server failure when the data locally when the call to remote data source is unsucessful',
          () async {
        // arrange

        when(mockRemoteDataSource.getAddressByCep(any))
            .thenThrow(ServerException());

        // act
        final result = await repository.getAddressByCep(tCep);
        // assert

        verify(mockRemoteDataSource.getAddressByCep(tCep));
        expect(result, equals(Left(ServerFailure())));
        verifyZeroInteractions(mockLocalDataSource);
      });
    });

    runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        //arrange

        when(mockLocalDataSource.getLastAdress())
            .thenAnswer((_) async => tAddressModel);
        //act
        final result = await repository.getAddressByCep(tCep);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastAdress());
        expect(result, equals(Right(tAddressModel)));
      });

      test(
          'should return CacheFailure data when there iss no cached data is present',
          () async {
        //arrange
        when(mockLocalDataSource.getLastAdress()).thenThrow(CacheException());
        //act
        final result = await repository.getAddressByCep(tCep);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastAdress());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
