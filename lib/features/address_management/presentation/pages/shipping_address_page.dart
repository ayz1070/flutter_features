import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_screen_size.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/shipping_address_bloc.dart';
import '../bloc/shipping_address_event.dart';
import '../bloc/shipping_address_state.dart';
import '../widgets/shipping_address_widgets/address_button.dart';
import '../widgets/shipping_address_widgets/address_empty_view.dart';
import '../widgets/shipping_address_widgets/address_list_view.dart';
import '../widgets/address_app_bar.dart';

class ShippingAddressPage extends StatelessWidget {
  ShippingAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ShippingAddressBloc을 통해 데이터를 불러오는 이벤트 발생
    context.read<ShippingAddressBloc>().add(LoadShippingAddressesEvent());

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimaryColor,
      appBar: AddressAppBar(
        title: "배송지 관리",
        onPressed: () {
          GoRouter.of(context).pop();

        },
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppScreenSize.webMaxSize, // 웹 크기에 맞추어 최대 크기 제한
          ),
          child: BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
            builder: (context, state) {
              if (state is ShippingAddressLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ShippingAddressLoaded) {
                final addresses = state.addresses;


                if (addresses.isEmpty) {
                  return Column(
                    children: [
                      Spacer(),
                      AddressEmptyView(),
                      Spacer(),
                      Container(
                        color: AppColors.backgroundSecondaryColor,
                        child: AddressButton(
                          title: "배송지 추가",
                          onPressed: () {
                            context.push('/my/address/add');
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      AddressListView(addresses: addresses), // AddressListView에 Expanded 추가
                      Container(
                        color:AppColors.backgroundSecondaryColor,
                        padding: EdgeInsets.all(16),
                        child: AddressButton(
                          title: "배송지 추가",
                          onPressed: () {
                            context.go('/my/address/add');
                          },
                        ),
                      ),
                    ],
                  );
                }
              } else if (state is ShippingAddressError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return Container(); // 기본 상태
            },
          ),
        ),
      ),
    );
  }
}