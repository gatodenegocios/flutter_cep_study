part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class GetAddressByCepEvent extends AddressEvent{
  final String cepString;

  GetAddressByCepEvent(this.cepString);

  
  @override
  List<Object> get props => [cepString];
}

