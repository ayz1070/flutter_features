import '../../domain/entities/shipping_address.dart';
import '../models/shipping_address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShippingAddressMapper {
  // Domain Entity -> Data Model 변환
  static ShippingAddressModel toModel(ShippingAddress entity) {
    return ShippingAddressModel(
      id: entity.id,
      userId: entity.userId,
      recipientName: entity.recipientName,
      phoneNumber: entity.phoneNumber,
      postalCode: entity.postalCode,
      address: entity.address,
      addressName: entity.addressName,
      detailAddress: entity.detailAddress,
      deliveryRequest: entity.deliveryRequest,
      isDefaultAddress: entity.isDefaultAddress,
      createdAt: entity.createdAt, // DateTime 그대로 사용
    );
  }

  // Data Model -> Domain Entity 변환
  static ShippingAddress toEntity(ShippingAddressModel model) {
    return ShippingAddress(
      id: model.id,
      userId: model.userId,
      recipientName: model.recipientName,
      phoneNumber: model.phoneNumber,
      postalCode: model.postalCode,
      address: model.address,
      addressName: model.addressName,
      detailAddress: model.detailAddress,
      deliveryRequest: model.deliveryRequest,
      isDefaultAddress: model.isDefaultAddress, // Boolean 그대로 사용
      createdAt: model.createdAt, // DateTime 그대로 사용
    );
  }

  // JSON -> Data Model 변환 (Firestore Timestamp -> DateTime 변환)
  static ShippingAddressModel fromJson(Map<String, dynamic> json) {
    return ShippingAddressModel(
      id: json['id'],
      userId: json['userId'],
      recipientName: json['recipientName'],
      phoneNumber: json['phoneNumber'],
      postalCode: json['postalCode'],
      address: json['address'],
      addressName: json['addressName'],
      detailAddress: json['detailAddress'],
      deliveryRequest: json['deliveryRequest'],
      isDefaultAddress: json['isDefaultAddress'], // 그대로 저장
      createdAt: (json['createdAt'] as Timestamp).toDate(), // Timestamp -> DateTime 변환
    );
  }

  // Data Model -> JSON 변환 (DateTime -> Firestore Timestamp 변환)
  static Map<String, dynamic> toJson(ShippingAddressModel model) {
    return {
      'id': model.id,
      'userId': model.userId,
      'recipientName': model.recipientName,
      'phoneNumber': model.phoneNumber,
      'postalCode': model.postalCode,
      'address': model.address,
      'addressName' :model.addressName,
      'detailAddress': model.detailAddress,
      'deliveryRequest': model.deliveryRequest,
      'isDefaultAddress': model.isDefaultAddress,
      'createdAt': Timestamp.fromDate(model.createdAt), // DateTime -> Timestamp 변환
    };
  }
}