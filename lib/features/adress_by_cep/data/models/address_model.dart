import 'package:flutter_cep_study/features/adress_by_cep/domain/entities/address.dart';

class AddressModel extends Address {
  AddressModel({
    required cep,
    required state,
    required city,
    required neighborhood,
    required street,
  }) : super(
            cep: cep,
            state: state,
            city: city,
            neighborhood: neighborhood,
            street: street);

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      cep: json['cep'],
      state: json['state'],
      city: json['city'],
      neighborhood: json['neighborhood'],
      street: json['street'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cep': cep,
      'state': state,
      'city': city,
      'neighborhood': neighborhood,
      'street': street,
    };
  }
    
}
