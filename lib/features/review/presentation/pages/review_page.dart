import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/review_add_bloc.dart';
import '../bloc/review_add_state.dart';
import '../bloc/review_bloc.dart';
import '../bloc/review_event.dart';
import '../bloc/review_state.dart';
import '../widgets/common_widgets/error_view.dart';
import '../widgets/common_widgets/review_app_bar.dart';
import '../widgets/common_widgets/skeleton_loader.dart';
import '../widgets/review_widgets/review_tab_bar.dart';
import '../widgets/review_widgets/review_tab_bar_view.dart';

// ReviewPage에서 BlocListener를 설정
class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  void initState() {
    super.initState();
    // ReviewBloc에 초기 데이터를 로드하는 이벤트 추가
    context.read<ReviewBloc>().add(FetchPurchasedProductDetailsEvent('test_user_id'));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundSecondaryColor,
        appBar: ReviewAppBar(
          title: "리뷰 관리",
          onBackPressed: Navigator.of(context).pop,
          bottomWidget: ReviewTabBar(),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<ReviewAddBloc, ReviewAddState>(
              listener: (context, state) {
                if (state is ReviewAdded || state is ReviewUpdated) {
                  // ReviewAdded 또는 ReviewUpdated 상태일 때 데이터 새로고침 이벤트 추가
                  context.read<ReviewBloc>().add(FetchPurchasedProductDetailsEvent('test_user_id'));
                }
              },
            ),
          ],
          child: BlocBuilder<ReviewBloc, ReviewState>(
            builder: (context, state) {
              if (state is ReviewLoading) {
                return ReviewSkeleton();
              } else if (state is ReviewLoaded) {
                return ReviewTabBarView(
                  productInfoList: state.productInfoList,
                  userReviews: state.userReviews,
                );
              } else {
                return ErrorView(message: '데이터를 불러오는데 문제가 발생했습니다.');
              }
            },
          ),
        ),
      ),
    );
  }
}

