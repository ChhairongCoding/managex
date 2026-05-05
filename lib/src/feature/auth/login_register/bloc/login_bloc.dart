import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockmanagement/src/feature/auth/login_register/bloc/login_event.dart';
import 'package:stockmanagement/src/feature/auth/login_register/bloc/login_state.dart';
import 'package:stockmanagement/src/feature/auth/login_register/repository/login_register_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRegisterRepo loginRegisterRepo;
  LoginBloc(this.loginRegisterRepo) : super(const LoginInitial()) {
    on<LoginSubmitted>(_onSubmitted);
  }
  void _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(const LoginLoading());
    try {
      await loginRegisterRepo.login(event.email, event.password);
      emit(const LoginSuccess());
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}
