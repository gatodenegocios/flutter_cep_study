import 'dart:convert';

import 'package:flutter_cep_study/core/error/exceptions.dart';
import 'package:flutter_cep_study/features/adress_by_cep/data/datasources/address_local_data_source.dart';
import 'package:flutter_cep_study/features/adress_by_cep/data/models/address_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixtures_reader.dart';
import 'address_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late AddressLocalDataSourceImpl dataSource;

  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        AddressLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastAddress',(){

    final tAddressModel = AddressModel.fromJson(json.decode(fixture('address_cached.json')));

    test('should return Address from SharedPreferences when theres is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(fixture('address_cached.json'));
        // act
        final result = await dataSource.getLastAdress() ;
        // assert

        verify(mockSharedPreferences.getString(CACHED_ADDRESS));
        expect(result, equals(tAddressModel));
      }
    );

    test('should throw CachedExpection when there is not a cached value',
    () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = dataSource.getLastAdress;
      // assert
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    }
    );
  });

  group('cachedAddress',(){
    final tAddressModel = AddressModel(cep: 'test', city: 'test', neighborhood: 'test', state: 'test', street: 'test');
    test('should call SharedPreferences to cache the data',
      () async {
        final tBool = Future.value(true);

        when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => tBool);
        // act
        dataSource.cacheAdress(tAddressModel);
        // assert
        final expectedJsonString = json.encode(tAddressModel.toJson());

        verify(mockSharedPreferences.setString(CACHED_ADDRESS, expectedJsonString));
        
      }
    );
  });
}
