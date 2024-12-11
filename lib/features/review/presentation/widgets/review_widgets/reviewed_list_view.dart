import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../bloc/review_bloc.dart';
import '../../bloc/review_event.dart';
import '../../bloc/review_state.dart';
import '../../pages/review_add_page.dart';
import 'reviewed_item.dart';
import '../../../domain/entities/review.dart';
import '../../vm/product_view_model.dart';

class ReviewedListView extends StatelessWidget {
  final List<Review> reviews;
  final List<ProductViewModel> products;

  const ReviewedListView({
    Key? key,
    required this.reviews,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ReviewLoaded) {
          if (reviews.isEmpty) {
            return Center(
              child: Text('리뷰가 없습니다.', style: AppTextStyles.medium12),
            );
          }

          final sortedReviews = List<Review>.from(reviews)
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

          return ListView.builder(
            itemCount: sortedReviews.length,
            itemBuilder: (context, index) {
              final review = sortedReviews[index];
              final productInfo = products.firstWhere(
                    (product) => product.productId == review.productId,
                orElse: () => ProductViewModel(
                  productId: review.productId,
                  productName: '알 수 없는 상품',
                  purchaseDate: DateTime.now(),
                  productImageUrl: '',
                ),
              );
              return ReviewedItem(
                review: review,
                productInfo: productInfo,
                onEdit: () {

                  _navigateToReviewEditPage(context, productInfo, review);
                },
                onDelete: () async {
                  // 삭제 이벤트 처리 후 새로고침
                  context.read<ReviewBloc>().add(DeleteReviewEvent(review.reviewId));
                },
              );
            },
          );
        } else if (state is ReviewError) {
          return Center(child: Text("리뷰를 불러오는 중 오류가 발생했습니다."));
        }
        return Container();
      },
    );
  }

  void _navigateToReviewEditPage(BuildContext context, ProductViewModel productInfo, Review review) async {
    final editedReview = await Navigator.of(context).push<Review>(
      MaterialPageRoute(
        builder: (context) => ReviewAddPage(
          productViewModel: productInfo,
          review: review,
        ),
      ),
    );

    if (editedReview != null) {
      context.read<ReviewBloc>().add(FetchPurchasedProductDetailsEvent('test_user_id'));
    }

    // final result = await context.push(
    //   '/my/review/edit/${productInfo.productId}',
    //   extra: productInfo,
    // );
    //
    // // 수정 완료 후 새로고침을 위해 result를 확인
    // if (result == true) {
    //   context.read<ReviewBloc>().add(FetchPurchasedProductDetailsEvent('test_user_id'));
    // }


  }
}