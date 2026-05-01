abstract class LoginEvent {
  const LoginEvent();
}

class LoginSubmit extends LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;
  LoginSubmitted({required this.email, required this.password});

  List<Object?> get props => [email, password];
}
