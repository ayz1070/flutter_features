import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/colors.dart';
import '../../../domain/entities/shipping_address.dart';
import '../../bloc/shipping_address_bloc.dart';
import '../../bloc/shipping_address_event.dart';
import '../../pages/shipping_address_add_page.dart';
import '../address_card.dart';

class AddressListView extends StatelessWidget {
  final List<ShippingAddress> addresses;

  const AddressListView({Key? key, required this.addresses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded( // ListView를 Expanded로 감싸 크기 제한
      child: Container(
        color: AppColors.backgroundSecondaryColor,
        child: ListView.builder(
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            final address = addresses[index];
            return AddressCard(
              name: address.recipientName,
              postalCode: address.postalCode,
              addressName: address.addressName ?? '배송지',
              phone: address.phoneNumber,
              address: address.address,
              detailAddress: address.detailAddress,
              isDefault: address.isDefaultAddress,
              onEdit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShippingAddressAddPage(
                      existingAddress: address, // 수정하려는 주소 전달
                    ),
                  ),
                );
              },
              onDelete: () {
                // Bloc에 삭제 이벤트를 전달
                context.read<ShippingAddressBloc>().add(RemoveShippingAddressEvent(address.id));
              },
            );
          },
        ),
      ),
    );
  }
}