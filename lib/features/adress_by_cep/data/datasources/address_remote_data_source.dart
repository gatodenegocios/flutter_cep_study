import 'dart:convert';
import 'dart:io';

import 'package:flutter_cep_study/core/error/exceptions.dart';
import 'package:flutter_cep_study/features/adress_by_cep/data/models/address_model.dart';
import 'package:http/http.dart' as http;

abstract class AddressRemoteDataSource {
  /// Calls the  endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<AddressModel> getAddressByCep(String cep);
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {


  final http.Client client;

  AddressRemoteDataSourceImpl({required this.client});


  @override
  Future<AddressModel> getAddressByCep(String cep) async{
    final response = await client.get(
      Uri.parse('https://brasilapi.com.br/api/cep/v1/$cep'), 
      headers:{'Content-Type': 'application/json'},
    );

    if(response.statusCode == 200){
      return AddressModel.fromJson(json.decode(response.body));
    }else{
      throw ServerException();
    } 
    
  }

}
