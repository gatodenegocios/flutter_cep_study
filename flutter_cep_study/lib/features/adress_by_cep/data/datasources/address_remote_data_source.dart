import 'package:flutter_cep_study/features/adress_by_cep/data/models/address_model.dart';

abstract class AddressRemoteDataSource {
  /// Calls the  endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<AddressModel> getAddressByCep(String cep);
}
