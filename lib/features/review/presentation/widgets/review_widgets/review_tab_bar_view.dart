import 'package:flutter/material.dart';
import 'package:flutter_features/features/review/presentation/widgets/review_widgets/purchased_product_list_view.dart';

import '../../../domain/entities/review.dart';
import '../../vm/product_view_model.dart';
import 'reviewed_list_view.dart';

class ReviewTabBarView extends StatelessWidget {
  final List<ProductViewModel> productInfoList;
  final List<Review> userReviews;

  ReviewTabBarView({
    Key? key,
    required this.productInfoList,
    required this.userReviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: DefaultTabController.of(context),
      children: [
        PurchasedProductListView(products: productInfoList, reviews: userReviews),
        ReviewedListView(products: productInfoList, reviews: userReviews,),
      ],
    );
  }
}