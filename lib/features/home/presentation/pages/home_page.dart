import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_features/core/theme/colors.dart';
import 'package:flutter_features/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_features/features/home/presentation/widgets/home_body_list_view.dart';
import 'package:flutter_features/features/home/presentation/widgets/profile_card.dart';

import '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimaryColorDark,
      appBar: AppBar(
        title: const Text("플러터 기능"),
        centerTitle: true,
        actions: [
          Icon(
            Icons.person_2_rounded,
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeInitial || state is HomeLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          return Column(
            children: [
              ProfileCard(profileViewModel: state.profileViewModel),
              HomeBodyListView(),
            ],
          );
        } else {
          return Center(
            child: Text("에러"),
          );
        }
      }),
    );
  }
}
