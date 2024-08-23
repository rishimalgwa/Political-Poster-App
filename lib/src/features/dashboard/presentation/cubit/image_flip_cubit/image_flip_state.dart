part of 'image_flip_cubit.dart';

abstract class ImageFlipState extends Equatable {
  const ImageFlipState();

  @override
  List<Object?> get props => [];
}

class ImageFlipInitial extends ImageFlipState {}

class ImageFlipLoading extends ImageFlipState {}

class ImageFlipSuccess extends ImageFlipState {
  final String flippedImagePath;
  final bool isLeft;

  const ImageFlipSuccess(this.flippedImagePath, this.isLeft);

  @override
  List<Object?> get props => [flippedImagePath, isLeft];
}

class ImageFlipFailure extends ImageFlipState {
  final String error;

  const ImageFlipFailure(this.error);

  @override
  List<Object?> get props => [error];
}
