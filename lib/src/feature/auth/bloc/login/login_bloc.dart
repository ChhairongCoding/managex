import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managex/src/feature/auth/bloc/login/login_event.dart';
import 'package:managex/src/feature/auth/bloc/login/login_state.dart';
import 'package:managex/src/feature/auth/repository/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  LoginBloc(this.authRepository) : super(const LoginInitial()) {
    on<LoginSubmitted>(_onSubmitted);
  }
  void _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(const LoginLoading());
    try {
      await authRepository.login(event.email, event.password);
      emit(const LoginSuccess());
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}
