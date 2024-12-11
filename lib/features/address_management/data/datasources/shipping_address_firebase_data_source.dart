import 'package:cloud_firestore/cloud_firestore.dart';
import '../mapper/shipping_address_mapper.dart';
import '../models/shipping_address_model.dart';
import 'shipping_address_data_source.dart';  // 추상 클래스 import

class ShippingAddressFirebaseDataSource implements ShippingAddressDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Firebase에서 개별 배송지 저장
  @override
  Future<void> saveShippingAddress(ShippingAddressModel address) async {
    CollectionReference addressesRef = _firestore.collection('addresses');

    // 주소 ID를 Document ID로 사용하여 저장
    await addressesRef.doc(address.id).set(ShippingAddressMapper.toJson(address));
  }

  // Firebase에서 모든 배송지 불러오기
  @override
  Future<List<ShippingAddressModel>> getShippingAddresses() async {
    // TODO 로그인한 유저 ID로 변경 필요
    String userId = "test_user_id"; // 실제로는 로그인한 유저의 ID를 받아와야 함

    CollectionReference addressesRef = _firestore.collection('addresses');

    // 유저 ID로 필터링하여 해당 유저의 배송지 정보만 불러옴
    QuerySnapshot querySnapshot = await addressesRef.where('userId', isEqualTo: userId).get();

    return querySnapshot.docs.map((doc) {
      return ShippingAddressMapper.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  @override
  Future<void> deleteShippingAddress(String addressId) async {
    CollectionReference addressesRef = _firestore.collection('addresses');

    await addressesRef.doc(addressId).delete();

  }

  @override
  Future<void> updateShippingAddress(ShippingAddressModel address) async{
    CollectionReference addressesRef = _firestore.collection('addresses');

    await addressesRef.doc(address.id).set(ShippingAddressMapper.toJson(address));
  }
}