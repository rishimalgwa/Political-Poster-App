import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:political_poster_app/src/features/auth/data/user_model.dart';
import 'package:political_poster_app/src/features/auth/domain/user_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  final _userRepo = UserRepository();
  void signup({required UserModel user}) {
    emit(SignupLoading());
    _userRepo.createUser(user: user).then((_) {
      emit(SignupSuccess());
    }).onError((s, t) {
      emit(SignupError());
    });
  }
}
