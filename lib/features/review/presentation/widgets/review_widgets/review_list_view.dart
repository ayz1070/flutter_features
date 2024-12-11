import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../domain/entities/review.dart';
import '../../bloc/review_bloc.dart';
import '../../bloc/review_event.dart';
import '../../pages/review_add_page.dart';
import '../../vm/product_view_model.dart';
import 'reviewed_item.dart';

class ReviewedListView extends StatelessWidget {
  final List<ProductViewModel> products;
  final List<Review> reviews;

  const ReviewedListView({Key? key, required this.products, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return Center(
        child: Text(
          '리뷰가 모두 삭제되었습니다.',
          style: AppTextStyles.medium12,
        ),
      );
    }

    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
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
            context.read<ReviewBloc>().add(DeleteReviewEvent(review.reviewId));
          },
        );
      },
    );
  }

  void _navigateToReviewEditPage(
      BuildContext context, ProductViewModel productInfo, Review review) async {
    final editedReview = await Navigator.of(context).push<Review>(
      MaterialPageRoute(
        builder: (context) => ReviewAddPage(
          productViewModel: productInfo,
          review: review,
        ),
      ),
    );

    if (editedReview != null) {
      context.read<ReviewBloc>().add(UpdateReviewEvent(editedReview));
    }
  }
}