import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_cep_study/core/utils/input_validator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';


void main(){
  late InputValidator inputValidator;

  setUp(() {
    inputValidator = InputValidator();
  });

  group('validate String',(){
    test('should return a String when the input String is valid with ',
      () async {
      // arrange
        final str = '85063040';
      // act
        final result = inputValidator.validate(str);
      // assert
        expect(result, Right('85063040'));
      }
    );

    test('should return a String when the input String is valid with hyphen',
      () async {
      // arrange
        final str = '00000-000';
      // act
        final result = inputValidator.validate(str);
      // assert
        expect(result, Right('00000000'));
      }
    );


    test('should return a failed when the String is not in the CEP format',
      () async {
      // arrange
        final str = '14584-abc';
      // act
        final result = inputValidator.validate(str);
      // assert
        expect(result, Left(InvalidInputFailure()));
      
      }
    );

    test('should return a failed when the String has more numbers than the limit',
      () async {
      // arrange
        final str = '14584854535678';
      // act
        final result = inputValidator.validate(str);
      // assert
        expect(result, Left(InvalidInputFailure()));
      
      }
    );

    test('should return a failed when the String is empty',
      () async {
      // arrange
        final str = '';
      // act
        final result = inputValidator.validate(str);
      // assert
        expect(result, Left(InvalidInputFailure()));
      
      }
    );
  
  });

}