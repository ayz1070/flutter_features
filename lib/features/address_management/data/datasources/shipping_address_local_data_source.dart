import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../mapper/shipping_address_mapper.dart';
import '../models/shipping_address_model.dart';
import 'shipping_address_data_source.dart';  // 추상 클래스 import

class ShippingAddressLocalDataSourceImpl implements ShippingAddressDataSource {
  static const _storageKeyPrefix = 'SHIPPING_ADDRESS_';
  SharedPreferences? _prefs;

  Future<SharedPreferences> _getPrefsInstance() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // 로컬에서 개별 배송지 저장
  @override
  Future<void> saveShippingAddress(ShippingAddressModel address) async {
    final prefs = await _getPrefsInstance();
    final addressJson = json.encode(ShippingAddressMapper.toJson(address));
    // 유니크한 키로 저장 (주소 ID 사용)
    await prefs.setString(_storageKeyPrefix + address.id, addressJson);
  }

  // 로컬에서 모든 배송지 불러오기
  @override
  Future<List<ShippingAddressModel>> getShippingAddresses() async {
    final prefs = await _getPrefsInstance();
    final keys = prefs.getKeys().where((key) => key.startsWith(_storageKeyPrefix));

    // 저장된 모든 주소를 가져와서 리스트로 변환
    return keys.map((key) {
      final jsonStr = prefs.getString(key);
      return ShippingAddressMapper.fromJson(json.decode(jsonStr!));
    }).toList();
  }

  @override
  Future<void> deleteShippingAddress(String addressId) {
    // TODO: 로컬에서 삭제 구현 필요
    throw UnimplementedError();
  }

  @override
  Future<void> updateShippingAddress(ShippingAddressModel address) {
    // TODO: implement updateShippingAddress
    throw UnimplementedError();
  }
}