import 'package:dartz/dartz.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/entities/address.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/repositories/address_by_cep_repository.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/usecases/get_address_by_cep.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';

import 'get_address_by_cep_test.mocks.dart';

//class MockAddressByCepRepository extends Mock
//    implements AddressByCepRepository {}

@GenerateMocks([AddressByCepRepository])
void main() {
  late GetAddressByCep usecase;
  late MockAddressByCepRepository mockAddressByCepRepository;

  setUp(() {
    mockAddressByCepRepository = MockAddressByCepRepository();
    usecase = GetAddressByCep(mockAddressByCepRepository);
  });

  final tCep = '85063040';

  final tAddress = Address(
    cep: 'test',
    city: 'test',
    neighborhood: 'test',
    state: 'test',
    street: 'test',
  );

  test(
    'should get address for the address by cep repository',
    () async {
      //arrange
      when(mockAddressByCepRepository.getAddressByCep(any))
          .thenAnswer((_) async => Right(tAddress));
      //act
      final result = await usecase(Params(cep: tCep));
      //assert
      expect(result, Right(tAddress));
      verify(mockAddressByCepRepository.getAddressByCep(tCep));
      verifyNoMoreInteractions(mockAddressByCepRepository);
    },
  );
}
