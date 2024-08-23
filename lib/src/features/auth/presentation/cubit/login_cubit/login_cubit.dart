import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:political_poster_app/src/features/auth/domain/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final _userRepo = UserRepository();
  void login({required String phoneNumber}) async {
    emit(LoginLoading());
    await _userRepo.isUserExist().then((value) {
      if (value) {
        emit(LoginSuccess());
      } else {
        emit(LoginError());
      }
    });
  }
}
