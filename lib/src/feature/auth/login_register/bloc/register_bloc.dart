import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockmanagement/src/feature/auth/login_register/bloc/register_event.dart';
import 'package:stockmanagement/src/feature/auth/login_register/bloc/register_state.dart';
import 'package:stockmanagement/src/feature/auth/login_register/repository/login_register_repo.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this.repo) : super(const RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<AuthCheckStarted>(_onAuthCheckStarted);
  }

  final LoginRegisterRepo repo;

  Future<void> _onAuthCheckStarted(
    AuthCheckStarted event,
    Emitter<RegisterState> emit,
  ) async {
    final user = await repo.getUser();
    if (user != null) {
      emit(Authenticated(user: user));
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
      await repo.register(
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
