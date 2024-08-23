part of 'leaders_photo_cubit.dart';

sealed class LeadersPhotoState extends Equatable {
  const LeadersPhotoState();

  @override
  List<Object> get props => [];
}

final class LeadersPhotoInitial extends LeadersPhotoState {}

final class LeadersPhotoLoading extends LeadersPhotoState {}

final class LeadersPhotoLoaded extends LeadersPhotoState {
  final List<String> imageUrls;
  const LeadersPhotoLoaded({required this.imageUrls});
}

final class LeadersPhotoError extends LeadersPhotoState {}
