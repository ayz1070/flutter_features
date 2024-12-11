// ImageAttachments Widget
import 'package:flutter/material.dart';
import 'package:flutter_features/features/review/presentation/widgets/review_add_widgets/review_add_image_item.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/theme/text_styles.dart';
import '../common_widgets/small_icon_button.dart';

class ReviewAddImageListView extends StatelessWidget {
  final List<XFile> images;
  final Function(XFile) onAddImage;
  final Function(XFile) onRemoveImage;

  const ReviewAddImageListView({required this.images, required this.onAddImage, required this.onRemoveImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('사진첨부 (최대 10개)', style: AppTextStyles.semiBold16),
        SizedBox(height: 12),
        SmallIconButton(
          title: "첨부하기",
          icon: Icons.camera_alt_outlined,
          onPressed: () async {
            final picker = ImagePicker();
            final image = await picker.pickImage(source: ImageSource.gallery);
            if (image != null) onAddImage(image);
          },
        ),
        SizedBox(height: 16),
        ReviewAddImageItem(
          images: images,
          onRemoveImage: onRemoveImage,
          onAddImage: () {},
        ),
      ],
    );
  }
}