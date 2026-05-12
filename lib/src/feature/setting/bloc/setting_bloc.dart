import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockmanagement/src/feature/setting/bloc/setting_event.dart';
import 'package:stockmanagement/src/feature/setting/bloc/setting_state.dart';
import 'package:stockmanagement/src/feature/setting/repository/setting_repository.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final SettingRepository _repo = SettingRepository();
  SettingBloc() : super(SettingInitial()) {
    on<SettingLogout>(_onLogout);
  }

  Future _onLogout(SettingLogout event, Emitter<SettingState> emit) async {
    emit(SettingLogoutLoading());
    try {
      await _repo.logout();
      emit(SettingLogoutSuccess());
    } catch (e) {
      emit(SettingLogoutFailed(error: e.toString()));
    }
  }
}
