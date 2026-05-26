import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managex/src/feature/auth/bloc/register/register_event.dart';
import 'package:managex/src/feature/auth/bloc/register/register_state.dart';
import 'package:managex/src/feature/auth/repository/auth_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this.authRepository) : super(const RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<AuthCheckStarted>(_onAuthCheckStarted);
  }

  final AuthRepository authRepository;

  Future<void> _onAuthCheckStarted(
    AuthCheckStarted event,
    Emitter<RegisterState> emit,
  ) async {
    final isLoggedIn = await authRepository.isLoggedIn();
    if (isLoggedIn) {
      final user = await authRepository.getUser();
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(const Unauthenticated());
      }
    } else {
      emit(const Unauthenticated());
    }
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(const RegisterLoading());

    if (event.password != event.confirmPassword) {
      emit(const RegisterError(message: "Passwords do not match"));
      return;
    }

    try {
      await authRepository.register(
        event.fullName,
        event.shopName,
        event.email,
        event.password,
        event.confirmPassword,
      );
      emit(const RegisterSuccess(message: "Register success"));
    } catch (e) {
      emit(RegisterError(message: e.toString()));
    }
  }
}
