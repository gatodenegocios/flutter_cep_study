part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();
  
  @override
  List<Object> get props => [];
}

class EmptyState extends AddressState {}
class LoadingState extends AddressState {}
class LoadedState extends AddressState {
  final Address address;

  LoadedState({required this.address});

  @override
  List<Object> get props => [address];
}

class ErrorState extends AddressState{
  final String message;

  ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

