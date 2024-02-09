import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hub008/models/user.dart';

abstract class LoginState extends Equatable {
  final User? loggedUser;
  final DioException? error;
  const LoginState({this.loggedUser, this.error});

  @override
  List<Object?> get props => [loggedUser, error];
}

class LoginInit extends LoginState {
  const LoginInit();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginDone extends LoginState {
  const LoginDone(User loggedUser) : super(loggedUser: loggedUser);
}

class LoginError extends LoginState {
  const LoginError(DioException error) : super(error: error);
}
