import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/colors.dart';
import '../../domain/entities/review.dart';
import '../bloc/review_add_bloc.dart';
import '../bloc/review_add_event.dart';
import '../bloc/review_add_state.dart';
import '../vm/product_view_model.dart';
import '../widgets/common_widgets/review_app_bar.dart';
import '../widgets/review_add_widgets/review_add_image_list_view.dart';
import '../widgets/review_add_widgets/review_add_product_info.dart';
import '../widgets/review_add_widgets/review_add_skeleton.dart';
import '../widgets/review_add_widgets/review_add_text_input.dart';
import '../widgets/review_add_widgets/review_submit_button.dart';
import '../widgets/review_add_widgets/star_rating_input.dart';
import 'dart:developer' as developer;


// ReviewAddPage
class ReviewAddPage extends StatefulWidget {
  final ProductViewModel productViewModel;
  final Review? review;

  const ReviewAddPage({
    required this.productViewModel,
    this.review,
  });

  @override
  _ReviewAddPageState createState() => _ReviewAddPageState();
}

class _ReviewAddPageState extends State<ReviewAddPage> {
  late final ReviewAddBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ReviewAddBloc>();
    _bloc.add(LoadReviewForEdit(widget.review));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimaryColor,
      appBar: ReviewAppBar(
        title: widget.review == null ? '리뷰 남기기' : '리뷰 수정하기',
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: BlocListener<ReviewAddBloc, ReviewAddState>(
        listener: (context, state) {
          if (state is ReviewAdded || state is ReviewUpdated) {
            Navigator.pop(context); // 상태가 변경되면 Navigator.pop을 호출
          }
        },
        child: BlocBuilder<ReviewAddBloc, ReviewAddState>(
          builder: (context, state) {
            developer.log("Current state in BlocBuilder: $state");

            if (state is ReviewAddLoading) {
              return ReviewAddSkeleton();
            } else if (state is ReviewAddLoaded) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReviewAddProductInfo(productViewModel: widget.productViewModel),
                    SizedBox(height: 48),
                    StarRatingInput(
                      initialRating: state.rating,
                      onRatingChanged: (rating) => _bloc.add(StarRatingChanged(rating)),
                    ),
                    SizedBox(height: 16),
                    ReviewAddTextInput(
                      initialValue: state.reviewText,
                      onChanged: (text) => _bloc.add(ReviewTextChanged(text)),
                    ),
                    SizedBox(height: 16),
                    ReviewAddImageListView(
                      images: state.attachedImages,
                      onAddImage: (image) => _bloc.add(AddImage(image)),
                      onRemoveImage: (image) => _bloc.add(RemoveImage(image)),
                    ),
                    Spacer(),
                    ReviewSubmitButton(
                      isEditing: widget.review != null,
                      onPressed: () {
                        final event = widget.review == null
                            ? SubmitReview(
                          userId: 'test_user_id',
                          productId: widget.productViewModel.productId,
                          starRating: state.rating,
                          reviewText: state.reviewText,
                          attachedImages: state.attachedImages,
                        )
                            : UpdateReview(
                          reviewId: widget.review!.reviewId,
                          userId: 'test_user_id',
                          productId: widget.productViewModel.productId,
                          starRating: state.rating,
                          reviewText: state.reviewText,
                          attachedImages: state.attachedImages,
                        );
                        _bloc.add(event);
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text("그 외"));
            }
          },
        ),
      ),
    );
  }
}