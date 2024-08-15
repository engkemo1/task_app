import 'package:equatable/equatable.dart';

import '../../data/model/login_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
final UserModel userModel;
  LoginSuccessState(this.userModel);

}

class LoginFailureState extends AuthState {
  final String error;

  LoginFailureState(this.error);

  @override
  List<Object> get props => [error];
}


