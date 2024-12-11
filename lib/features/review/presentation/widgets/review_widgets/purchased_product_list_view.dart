import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/review.dart';
import '../../bloc/review_bloc.dart';
import '../../bloc/review_event.dart';
import '../../vm/product_view_model.dart';
import 'purchased_product_item.dart';

class PurchasedProductListView extends StatelessWidget {
  final List<ProductViewModel> products;
  final List<Review> reviews;

  const PurchasedProductListView({Key? key, required this.products, required this.reviews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 8.0),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final productInfo = products[index];
        return PurchasedProductItem(
          productViewModel: productInfo,
          onAddPressed: () {
            context.read<ReviewBloc>().add(FetchPurchasedProductDetailsEvent(reviews[0].userId));
          },
        );
      },
    );
  }
}
