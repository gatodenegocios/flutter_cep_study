import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_cep_study/core/error/exceptions.dart';
import 'package:flutter_cep_study/features/adress_by_cep/data/datasources/address_remote_data_source.dart';
import 'package:flutter_cep_study/features/adress_by_cep/data/models/address_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixtures_reader.dart';

import 'package:http/http.dart' as http;

import 'address_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main(){
  late AddressRemoteDataSource dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = AddressRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClient200(){
    when(mockHttpClient.get(any,headers: anyNamed('headers'))).thenAnswer((_) async => http.Response(fixture('address.json'),200));
  }
  void setUpMockHttpClientFailure404(){
    when(mockHttpClient.get(any,headers: anyNamed('headers'))).thenAnswer((_) async => http.Response('SomethingWentWrong',404));
  }


  group('getAddress',(){
    final tCep = '89010025';

    final tAddressModel = AddressModel.fromJson(json.decode(fixture('address.json')));


    test('should return a valide AddressModel from a GET request on a URL with a string being the endpoint and with application/json header when the resposne code is 200',
      () async {
        // arrange
        setUpMockHttpClient200();
        // act
        final result = await dataSource.getAddressByCep(tCep);
        // assert
        verify(
          mockHttpClient.get(
            Uri.parse('https://brasilapi.com.br/api/cep/v1/$tCep'), 
            headers:{'Content-Type': 'application/json'}
          )
        );

        expect(result, equals(tAddressModel));
        
      }
    );


     test('should throw a ServerException from a GET request on a URL with a string being the endpoint and with application/json header when the resposne code isnt 200',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getAddressByCep;
        // assert
        
        expect(()=> call(tCep), throwsA(TypeMatcher<ServerException>()));
        
      }
    );
  });
}