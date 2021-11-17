import 'dart:convert';
import 'dart:math';

import 'package:flutter_cep_study/features/adress_by_cep/data/models/address_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  final tAddresModel = AddressModel(
      cep: "test",
      neighborhood: "test",
      state: "test",
      city: "test",
      street: "test");

  test('should be a subclass of Adress Entity', () async {
    // assert
    expect(tAddresModel, isA<AddressModel>());
  });

  test('should return a valid model', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(fixture('address.json'));

    // act
    final result = AddressModel.fromJson(jsonMap);
    // assert

    expect(result, tAddresModel);
  });

  test('should return a JSON container the proper data', () async {
    // act
    final result = tAddresModel.toJson();
    // assert
    final mapExpected = {
      "cep": "test",
      "state": "test",
      "city": "test",
      "neighborhood": "test",
      "street": "test",
    };
    expect(result, mapExpected);
  });
}
