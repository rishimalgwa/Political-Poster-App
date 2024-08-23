import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

part 'image_flip_state.dart';

class ImageFlipCubit extends Cubit<ImageFlipState> {
  ImageFlipCubit() : super(ImageFlipInitial());

  Future<void> flipImage(String imagePath, bool isLeft) async {
    if (imagePath.isEmpty) return;

    emit(ImageFlipLoading());

    try {
      final File imageFile = File(imagePath);

      // Decode the image
      final img.Image? originalImage =
          img.decodeImage(await imageFile.readAsBytes());

      if (originalImage != null) {
        // Flip the image horizontally
        final img.Image flippedImage = img.flipHorizontal(originalImage);

        // Get the directory to save the image
        final Directory directory = await getApplicationDocumentsDirectory();
        final String path =
            '${directory.path}/flipped_image_${isLeft ? 'left' : 'right'}_${DateTime.now().millisecondsSinceEpoch}.png';

        // Save the flipped image
        final File flippedImageFile = File(path)
          ..writeAsBytesSync(img.encodePng(flippedImage));

        emit(ImageFlipSuccess(flippedImageFile.path, isLeft));
      } else {
        emit(const ImageFlipFailure("Failed to decode image."));
      }
    } catch (e) {
      emit(ImageFlipFailure("Error flipping image: $e"));
    }
  }
}
