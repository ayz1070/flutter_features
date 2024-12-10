import '../../features/cart/domain/entities/delivery_policy.dart';

class UserModel{
  final String id;
  final String name;
  final String profileImage;

  UserModel({required this.id,required this.name, required this.profileImage});


}

class TestData{
  static UserModel loginedUser = UserModel(id: "test_user_id", name: "제갈철수", profileImage: "https://picsum.photos/200/300");
  static final deliveryPolicy = DeliveryPolicy(id: "test_delivery_policy_id", baseShippingFee: 2500, companyName: "대한통운", extraFee: 1000, estimatedDeliveryTime: 1);

}

