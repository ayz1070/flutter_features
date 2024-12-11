import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/shipping_address_add_bloc.dart';
import '../../bloc/shipping_address_add_event.dart';


class AddressTags extends StatelessWidget {
  final List<String> tags = ['집', '가족', '회사', '친구', '학교'];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: tags.map((tag) => _buildTagButton(tag, context)).toList(),
    );
  }

  Widget _buildTagButton(String label, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context
            .read<ShippingAddressAddBloc>()
            .add(AddressNameChanged(addressName: label));
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.grey[200],
      ),
      child: Text(label),
    );
  }
}