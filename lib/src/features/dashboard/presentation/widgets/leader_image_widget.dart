import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:political_poster_app/src/features/dashboard/presentation/cubit/leaders_photo_cubit/leaders_photo_cubit.dart';

class LeaderImageWidget extends StatelessWidget {
  const LeaderImageWidget({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final selectedImagesLength =
        context.watch<LeadersPhotoCubit>().selectedImages.length;

    // Adjust the radius based on the number of selected images
    final double outerRadius = selectedImagesLength == 5
        ? 26
        : selectedImagesLength == 6
            ? 22
            : 33;
    final double innerRadius = selectedImagesLength == 5
        ? 25
        : selectedImagesLength == 6
            ? 21
            : 32;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        radius: outerRadius,
        backgroundColor: Colors.red,
        child: CircleAvatar(
          radius: innerRadius,
          backgroundImage: imagePath.startsWith('assets/')
              ? AssetImage(imagePath) as ImageProvider
              : FileImage(File(imagePath)),
        ),
      ),
    );
  }
}
