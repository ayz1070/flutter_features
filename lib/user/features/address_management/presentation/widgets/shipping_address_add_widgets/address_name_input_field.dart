import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/shipping_address_add_bloc.dart';
import '../../bloc/shipping_address_add_event.dart';
import '../../bloc/shipping_address_add_state.dart';


class AddressNameInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '배송지명(선택)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        BlocBuilder<ShippingAddressAddBloc, ShippingAddressAddState>(
          builder: (context, state) {
            return TextFormField(
              decoration: InputDecoration(
                hintText: '배송지명을 직접 입력하시거나 선택해주세요',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => context
                  .read<ShippingAddressAddBloc>()
                  .add(AddressNameChanged(addressName: value)),
            );
          },
        ),
      ],
    );
  }
}