abstract class SettingState {}

class SettingInitial extends SettingState {}

class SettingLoading extends SettingState {}

class SettingLoaded extends SettingState {
  final String message;
  SettingLoaded({required this.message});

  List<Object?> get props => [message];
}

class SettingFailure extends SettingState {
  final String error;
  SettingFailure({required this.error});

  List<Object?> get props => [error];
}

class SettingLogoutSuccess extends SettingState {}

class SettingLogoutFailed extends SettingState {
  final String error;
  SettingLogoutFailed({required this.error});

  List<Object?> get props => [error];
}

class SettingLogoutLoading extends SettingState {}
