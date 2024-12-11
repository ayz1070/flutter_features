import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/theme/colors.dart';

class ReviewAddImageItem extends StatelessWidget {
  final List<XFile> images;
  final Function(XFile) onRemoveImage;
  final Function onAddImage;

  const ReviewAddImageItem({
    required this.images,
    required this.onRemoveImage,
    required this.onAddImage,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: images.map((image) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: kIsWeb
                  ? Image.network(
                image.path,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              )
                  : Image.file(
                File(image.path),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () {
                  onRemoveImage(image);
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.textSecondaryColor,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}