import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_features/features/point/presentation/pages/point_skeleton_page.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/test_data.dart';
import '../../domain/entities/point_entity.dart';
import '../bloc/point_bloc.dart';
import '../bloc/point_event.dart';
import '../bloc/point_state.dart';
import '../widgets/point_empty_list_view.dart';
import '../widgets/point_list_view.dart';
import '../widgets/point_summary.dart';
import '../widgets/point_tab_bar.dart';
import '../widgets/point_to_review_button.dart';

class PointPage extends StatefulWidget {
  @override
  _PointPageState createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  @override
  void initState() {
    super.initState();

    final userId = TestData.loginedUser.id;

    context.read<PointBloc>().add(FetchPointsEvent(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PointBloc, PointState>(
      builder: (context, state) {
        if (state is PointLoadingState) {
          return PointSkeletonPage();
        } else if (state is PointLoadedState) {
          return DefaultTabController(
            length: 3, // 전체, 적립/사용, 구매/환불 탭
            child: Scaffold(
              backgroundColor: AppColors.backgroundPrimaryColor,
              appBar: AppBar(
                backgroundColor: AppColors.backgroundPrimaryColor,
                title: Text(
                  '포인트',
                  style: AppTextStyles.bold18,
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PointSummary(pointSummaryViewModel : state.pointSummaryViewModel),
                  PointToReviewBar(),
                  PointTabBar(),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: AppColors.dividerPrimaryColor,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        PointListView(pointViewModels: state.pointViewModels), // 전체
                        PointListView(pointViewModels: state.pointSummaryViewModel.earnedPointViewModels), // 적립/사용
                        PointListView(pointViewModels: state.pointSummaryViewModel.usedPointViewModels), // 적립/사용
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }else{
          return CircularProgressIndicator();
        }
      }
    );
  }
}
