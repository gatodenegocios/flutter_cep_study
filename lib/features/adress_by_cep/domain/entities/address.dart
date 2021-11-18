import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String cep;
  final String state;
  final String city;
  final String neighborhood;
  final String street;

  Address({
    required this.cep,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.street,
  });

  @override
  List<Object> get props => [cep, state, city, neighborhood, street];
}
