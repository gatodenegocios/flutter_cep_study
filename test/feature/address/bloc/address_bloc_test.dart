import 'package:flutter_cep_study/features/adress_by_cep/domain/usecases/get_address_by_cep.dart';
import 'package:flutter_cep_study/features/adress_by_cep/presentation/bloc/address_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/usecases/get_address_by_cep.dart' as AddressByCep;

import 'address_bloc_test.mocks.dart';
// import '../../../../lib/features/adress_by_cep/domain/usecases/get_address_by_cep.dart';

@GenerateMocks([AddressByCep.GetAddressByCep])
void main() {
  late AddressBloc bloc;

  late MockGetAddressByCep getAddressByCep;

  setUp((){
    getAddressByCep = MockGetAddressByCep();
    bloc = AddressBloc(getAddress: getAddressByCep);
  });

  // test('initialState should be Empty',()async{
  //   //assert

  //   expect(bloc.initialState, equals(Empty()));
  // });

}