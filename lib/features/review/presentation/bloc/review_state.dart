import 'package:equatable/equatable.dart';
import '../../domain/entities/review.dart';
import '../vm/product_view_model.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object?> get props => [];
}

// 초기 상태: 앱이 시작되거나 특정 화면이 초기화될 때 설정됨
class ReviewInitial extends ReviewState {}

// 로딩 상태: 데이터 요청 또는 처리 중인 상태, 로딩 인디케이터 표시 등에 사용
class ReviewLoading extends ReviewState {}

// 데이터 로드 완료 상태: 데이터가 성공적으로 불러와졌을 때 사용
class ReviewLoaded extends ReviewState {
  final List<ProductViewModel> productInfoList;
  final List<Review> userReviews;

  const ReviewLoaded(this.productInfoList, this.userReviews);

  @override
  List<Object?> get props => [productInfoList, userReviews];
}

// 에러 상태: 데이터 요청 실패 또는 특정 작업 중 오류가 발생했을 때 사용
class ReviewError extends ReviewState {
  final String message;

  const ReviewError(this.message);

  @override
  List<Object?> get props => [message];
}