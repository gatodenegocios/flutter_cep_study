import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/entities/address.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/usecases/get_address_by_cep.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final GetAddressByCep getAddress;

   

  AddressBloc({required this.getAddress}) : super(Empty()) {
    on<AddressEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
