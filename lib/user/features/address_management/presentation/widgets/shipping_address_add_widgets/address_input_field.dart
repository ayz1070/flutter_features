import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpostal/kpostal.dart';

import '../../bloc/shipping_address_add_bloc.dart';
import '../../bloc/shipping_address_add_event.dart';
import '../../bloc/shipping_address_add_state.dart';


class AddressInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '주소 *',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: BlocBuilder<ShippingAddressAddBloc, ShippingAddressAddState>(
                builder: (context, state) {
                  return TextFormField(
                    decoration: InputDecoration(
                      hintText: state.address.isEmpty ? '주소를 입력하세요' : state.address,
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                  );
                },
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => KpostalView(
                      useLocalServer: false,
                      callback: (Kpostal result) {
                        context.read<ShippingAddressAddBloc>().add(AddressChanged(address: result.address));
                      },
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.grey[300],
              ),
              child: Text('주소찾기'),
            ),
          ],
        ),
        SizedBox(height: 8),
        BlocBuilder<ShippingAddressAddBloc, ShippingAddressAddState>(
          builder: (context, state) {
            return TextFormField(
              decoration: InputDecoration(
                hintText: '상세주소',
                border: OutlineInputBorder(),
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