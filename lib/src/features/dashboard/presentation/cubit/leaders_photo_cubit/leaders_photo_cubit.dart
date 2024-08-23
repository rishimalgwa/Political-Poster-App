import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:political_poster_app/src/common/contants/asstes_path.dart';

part 'leaders_photo_state.dart';

class LeadersPhotoCubit extends Cubit<LeadersPhotoState> {
  LeadersPhotoCubit() : super(LeadersPhotoInitial());
  Set<String> selectedImages = {
    leader1Path,
    leader2Path,
    leader3Path,
  };
  Set<String> allImages = {
    leader1Path,
    leader2Path,
    leader3Path,
  };
  void getLeadersPhoto() {
    emit(LeadersPhotoLoading());
    emit(LeadersPhotoLoaded(imageUrls: selectedImages.toList()));
  }
}
