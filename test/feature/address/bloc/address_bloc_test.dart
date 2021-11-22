import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cep_study/core/error/failures.dart';
import 'package:flutter_cep_study/core/utils/input_validator.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/entities/address.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/usecases/get_address_by_cep.dart';
import 'package:flutter_cep_study/features/adress_by_cep/presentation/bloc/address_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/usecases/get_address_by_cep.dart' as AddressByCep;


import '../../../fixtures/fixtures_reader.dart';
import 'address_bloc_test.mocks.dart';
// import '../../../../lib/features/adress_by_cep/domain/usecases/get_address_by_cep.dart';

@GenerateMocks([AddressByCep.GetAddressByCep])
@GenerateMocks([InputValidator])
void main() {
  late AddressBloc bloc;

  late MockGetAddressByCep mockGetAddressByCep;
  late MockInputValidator mockInputValidator;

  setUp((){
    mockGetAddressByCep = MockGetAddressByCep();
    mockInputValidator = MockInputValidator();
    bloc = AddressBloc(getAddress: mockGetAddressByCep,validator: mockInputValidator);
  });

  
  

  test('initialState should be Empty',()async{
    //assert

    expect(bloc.state, equals(EmptyState()));
  });

  group('GetAddress from cep',(){
    final String tCep = '85063040';
    final Address tAddress = Address(cep: '', city: '', neighborhood: '', state: '', street: '');

    void setUpMockInputValidatorSuccess(){
      when(mockInputValidator.validate(any)).thenReturn(Right(tCep));
    }
    void setUpMockInputSuccess(){
      setUpMockInputValidatorSuccess();
      when(mockGetAddressByCep(any)).thenAnswer((_) async =>Right(tAddress));
    }

    test('should call the input validator to validate the string',
      () async {
        // arrange
        setUpMockInputSuccess();
        
        // act
        bloc.add(GetAddressByCepEvent(tCep));

        await untilCalled(mockInputValidator.validate(tCep));
        
        // assert

        verify(mockInputValidator.validate(tCep));
      
      }
    );

    blocTest<AddressBloc, AddressState>(
      'emits [] when nothing is added',
      build: () => bloc,
      expect: () => [],
    );

    blocTest<AddressBloc, AddressState>(
      'should emit [ErrorState] when the string isnt valid', 
      build: (){
            when(mockInputValidator.validate(any)).thenReturn(Left(InvalidInputFailure()));
            return bloc;
      },
          act: (bloc) => bloc.add(GetAddressByCepEvent(tCep)),

      
      expect: () => [
        ErrorState(message: INVALIDE_INPUT_FAILURE_MESSAGE),
      ],
    );


    test('should get data from the concrete case',
      () async {
        // arrange
        setUpMockInputSuccess();
        // act
        bloc.add(GetAddressByCepEvent(tCep));

        await untilCalled(mockGetAddressByCep(any));
        // assert

        verify(mockGetAddressByCep(Params(cep:tCep)));
        
      }
    );

    blocTest<AddressBloc, AddressState>(
      'should emit [LoadingState, LoadedState] when the data  is gottens sucessfuly', 
      build: (){
            setUpMockInputSuccess();
            return bloc;
      },
      act: (bloc) => bloc.add(GetAddressByCepEvent(tCep)),
      
      expect: () => [
        LoadingState(),
        LoadedState(address: tAddress),
      ],
    );

    blocTest<AddressBloc, AddressState>(
      'should emit [LoadingState, ErrorState] when getting data fails', 
      build: (){
            setUpMockInputValidatorSuccess();
            when(mockGetAddressByCep(any)).thenAnswer((realInvocation) async => Left(ServerFailure()));
            return bloc;
      },
      act: (bloc) => bloc.add(GetAddressByCepEvent(tCep)),
      
      expect: () => [
        LoadingState(),
        ErrorState(message: SERVER_FAILURE_MESSAGE),
      ],
    );

    blocTest<AddressBloc, AddressState>(
      'should emit [LoadingState, ErrorState] with a proper message when the getting data fails', 
      build: (){
            setUpMockInputValidatorSuccess();
            when(mockGetAddressByCep(any)).thenAnswer((realInvocation) async => Left(ServerFailure()));
            return bloc;
      },
      act: (bloc) => bloc.add(GetAddressByCepEvent(tCep)),
      
      expect: () => [
        LoadingState(),
        ErrorState(message: SERVER_FAILURE_MESSAGE),
      ],
    );


  });



}