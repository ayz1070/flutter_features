import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/usecases/fetch_login_user_grade_use_case.dart';
import '../bloc/my_grade_bloc.dart';
import '../bloc/my_grade_event.dart';
import '../bloc/my_grade_state.dart';
import '../widgets/grade_summary.dart';
import '../widgets/my_grade_profile.dart';
import '../widgets/my_grade_tab_bar.dart';
import '../widgets/grade_standard_detail.dart';
import '../widgets/grade_list_item.dart';

class MyGradePage extends StatelessWidget {
  MyGradePage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final fetchUserGradeUseCase = context.read<
            FetchLoginUserGradeUseCase>(); // FetchLoginUserGradeUseCase 가져오기
        return MyGradeBloc(fetchUserGradeUseCase: fetchUserGradeUseCase)
          ..add(LoadMyGradeEvent(documentId: 'test')); // documentId 전달
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.backgroundSecondaryColor,
          appBar: AppBar(
            title: Text(
              '멤버십',
              style: AppTextStyles.bold18,
            ),
            leading: Icon(Icons.arrow_back),
            centerTitle: true,
            backgroundColor: AppColors.backgroundPrimaryColor,
          ),
          body: BlocBuilder<MyGradeBloc, MyGradeState>(
            builder: (context, state) {
              if (state is MyGradeLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MyGradeLoadedState) {
                return Column(
                  children: [
                    MyGradeProfile(
                      userGrade: state.userGrade,
                      grade: state.grades.first,
                    ),
                    GradeSummary(),

                  ],
                );
              } else if (state is MyGradeErrorState) {
                return Center(child: Text('오류: ${state.message}')); // 에러 발생 시
              } else {
                return Center(child: Text('오류 발생'));
              }
            },
          ),
        ),
      ),
    );
  }
}
