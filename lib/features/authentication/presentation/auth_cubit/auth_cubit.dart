import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/authentication/data/repo/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitialState());

  static AuthCubit get(BuildContext context) => BlocProvider.of<AuthCubit>(context);

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    emit(LoginLoadingState());
    var result = await authRepo.login(phone, password);
    result.fold(
          (failure) {
        emit(LoginFailureState(failure.errorMessages));
      },
          (user) {
        emit(LoginSuccessState(user));
      },
    );
  }
}
