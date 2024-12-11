import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_features/features/address_management/presentation/widgets/shipping_address_add_widgets/red_dot.dart';

import '../../../../../core/theme/colors.dart';
import '../../bloc/shipping_address_add_bloc.dart';
import '../../bloc/shipping_address_add_event.dart';
import '../../bloc/shipping_address_add_state.dart';

class AddressDetailInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '상세 주소',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            RedDot(),
          ],
        ),
        SizedBox(height: 8),
        BlocBuilder<ShippingAddressAddBloc, ShippingAddressAddState>(
          builder: (context, state) {
            return TextFormField(
              initialValue: state.addressDetail ?? '',
              decoration: InputDecoration(
                hintText: '상세 주소 입력',
                hintStyle: TextStyle(
                  color: AppColors.textHintPrimaryColor,
                ),
                fillColor: AppColors.textFieldBackgroundPrimaryColor,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) => context
                  .read<ShippingAddressAddBloc>()
                  .add(AddressDetailChanged(addressDetail: value)),
            );
          },
        ),
      ],
    );
  }
}