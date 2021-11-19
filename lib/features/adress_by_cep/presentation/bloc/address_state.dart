part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();
  
  @override
  List<Object> get props => [];
}

class Empty extends AddressState {}
class Loading extends AddressState {}
class Loaded extends AddressState {
  final Address address;

  Loaded({required this.address});

  @override
  List<Object> get props => [address];
}

class Error extends AddressState{
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}

