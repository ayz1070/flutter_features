import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../entities/shipping_address_entity.dart';

abstract class ShippingAddressLocalDataSource {
  Future<void> saveShippingAddress(List<ShippingAddressEntity> addresses);
  Future<List<ShippingAddressEntity>> getShippingAddresses();
}

class ShippingAddressLocalDataSourceImpl implements ShippingAddressLocalDataSource {
  static const _storageKey = 'SHIPPING_ADDRESSES';

  @override
  Future<void> saveShippingAddress(List<ShippingAddressEntity> addresses) async {
    final prefs = await SharedPreferences.getInstance();
    final addressesJson = addresses.map((address) => json.encode(address.toMap())).toList();
    await prefs.setStringList(_storageKey, addressesJson);
  }

  @override
  Future<List<ShippingAddressEntity>> getShippingAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final addressesJson = prefs.getStringList(_storageKey);

    if (addressesJson != null) {
      return addressesJson.map((jsonStr) => ShippingAddressEntity.fromMap(json.decode(jsonStr))).toList();
    } else {
      return [];
    }
  }
}