import 'package:flutter_features/features/point/presentation/vm/point_view_model.dart';

import '../../../../core/utils/formatter.dart';

class PointSummaryViewModel {
  final List<PointViewModel> points;

  PointSummaryViewModel(this.points);

  /// 총 포인트 계산
  double get totalPoint =>
      points.fold(0, (sum, point) => sum + point.pointPrice);

  /// 포인트를 포맷팅된 문자열로 반환
  String get formattedTotalPoint => Formatter.formatPrice(totalPoint);

  /// 적립 포인트 ViewModel 리스트 필터링
  List<PointViewModel> get earnedPointViewModels =>
      points.where((point) => point.isEarned).toList();

  /// 사용 포인트 ViewModel 리스트 필터링
  List<PointViewModel> get usedPointViewModels =>
      points.where((point) => !point.isEarned).toList();

  /// 개월 수에 따라 리스트 필터링
  List<PointViewModel> filterPointsByDuration(int months) {
    final now = DateTime.now();
    final thresholdDate = DateTime(now.year, now.month - months, now.day);

    return points.where((point) {
      return point.createdAt.isAfter(thresholdDate);
    }).toList();
  }
}
