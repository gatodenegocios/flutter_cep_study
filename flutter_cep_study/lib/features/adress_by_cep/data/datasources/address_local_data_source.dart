import 'package:flutter_cep_study/features/adress_by_cep/data/models/address_model.dart';

abstract class AddressLocalDataSource {
  /// Gets the cached [AddressModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  ///  Throws [CacheException] if no cached data is present.
  Future<AddressModel> getLastAdress();

  Future<void> cacheAdress(AddressModel addressToCache);
}
