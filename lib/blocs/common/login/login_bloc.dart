import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hub008/blocs/common/login/login_event.dart';
import 'package:hub008/blocs/common/login/login_state.dart';
import 'package:hub008/config/constants.dart';
import 'package:hub008/core/data_state.dart';
import 'package:hub008/repos/common/login_repo.dart';
import 'package:hub008/utils/shared_pref_utils.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo _loginRepo;
  LoginBloc(this._loginRepo) : super(const LoginInit()) {
    on<Login>(onLogin);
    on<Logout>(onLogout);
  }

  FutureOr<void> onLogin(Login event, Emitter<LoginState> emit) async {
    emit(const LoginLoading());
    final dataState = await _loginRepo.login();
    if (dataState is DataSuccess) {
      await setToPreference(Constants.loggedUser, dataState.data?.toJson());
      emit(LoginDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(LoginError(dataState.error!));
    }
  }

  FutureOr<void> onLogout(Logout event, Emitter<LoginState> emit) async {
    await clearPref();
  }
}
