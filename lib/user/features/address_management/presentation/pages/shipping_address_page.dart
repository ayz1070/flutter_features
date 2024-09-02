import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/theme/button_theme.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../domain/models/shipping_address.dart';
import '../bloc/shipping_address_bloc.dart';
import '../widgets/address_card.dart';
import 'shipping_address_add_page.dart';
import 'package:velocity_x/velocity_x.dart';

class ShippingAddressPage extends StatelessWidget {
  ShippingAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _checkSavedAddresses();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '배송지 관리',
          style: AppTextStyles.appBarTextStyle,
        ).centered(),
      ),
      body: BlocBuilder<ShippingAddressBloc, List<ShippingAddress>>(
        builder: (context, addresses) {
          if (addresses.isEmpty) {
            return _buildEmptyAddressView(context);
          } else {
            return ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return AddressCard(
                  name: address.name,
                  addressName: address.addressName ?? '배송지',
                  phone: address.phoneNumber,
                  address: address.address,
                  isDefault: address.isDefaultAddress,
                  onEdit: () {
                    // 수정 기능 구현 (예: 수정 페이지로 이동)
                  },
                  onDelete: () {
                    // 삭제 기능 구현
                    context
                        .read<ShippingAddressBloc>()
                        .removeShippingAddress(address.id);
                  },
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: _buildAddAddressButton(context),
    );
  }

  Future<void> _checkSavedAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final addressesJson = prefs.getStringList('SHIPPING_ADDRESSES');

    if (addressesJson != null) {
      final addresses =
          addressesJson.map((jsonStr) => json.decode(jsonStr)).toList();
      print('Saved Addresses: $addresses');
    } else {
      print('No addresses found in SharedPreferences.');
    }
  }

  Widget _buildEmptyAddressView(BuildContext context) {
    return Center(
      child: Text(
        '등록된 배송지가 없습니다',
        style: AppTextStyles.bodyText, // 기존 스타일을 AppTextStyles로 변경
      ),
    );
  }

  Widget _buildAddAddressButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShippingAddressAddPage()),
          );
        },
        style: AppButtonTheme.mainButtonStyle,
        child: Text(
          '배송지 추가',
          style: AppTextStyles.buttonText,
        ),
      ),
    );
  }
}
