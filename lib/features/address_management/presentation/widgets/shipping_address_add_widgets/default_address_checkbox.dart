import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/shipping_address_add_bloc.dart';
import '../../bloc/shipping_address_add_event.dart';
import '../../bloc/shipping_address_add_state.dart';

class DefaultAddressCheckbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShippingAddressAddBloc, ShippingAddressAddState>(
      builder: (context, state) {
        return Row(
          children: [
            Checkbox(
              value: state.isDefaultAddress,
              onChanged: (bool? value) {
                context
                    .read<ShippingAddressAddBloc>()
                    .add(IsDefaultAddressToggled(isDefaultAddress: value ?? false));
              },
              visualDensity: VisualDensity(horizontal: -4.0),
            ),
            SizedBox(width: 4),
            Text('기본 배송지로 설정'),
          ],
        );
      },
    );
  }
}