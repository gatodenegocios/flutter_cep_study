import 'dart:convert';

import 'package:flutter_cep_study/core/error/exceptions.dart';
import 'package:flutter_cep_study/features/adress_by_cep/data/models/address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AddressLocalDataSource {
  /// Gets the cached [AddressModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  ///  Throws [CacheException] if no cached data is present.
  Future<AddressModel> getLastAdress();

  Future<void> cacheAdress(AddressModel addressToCache);
}

const String CACHED_ADDRESS = 'CACHED_ADDRESS';

class AddressLocalDataSourceImpl implements AddressLocalDataSource {
  final SharedPreferences sharedPreferences;

  AddressLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<AddressModel> getLastAdress() {
    final jsonString = sharedPreferences.getString(CACHED_ADDRESS);

    if(jsonString!=null){
      return Future.value(AddressModel.fromJson(json.decode(jsonString)));
    }else{
      throw CacheException();
    }


  }

  @override
  Future<void> cacheAdress(AddressModel addressToCache) {
    return sharedPreferences.setString(CACHED_ADDRESS, json.encode(addressToCache.toJson()));
  }
}
