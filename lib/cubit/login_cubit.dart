import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jotihunt/cubit/login_state.dart';
import 'package:equatable/equatable.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState.unauthenticated());

  void login() {
    emit(const LoginState.authenticated());
  }

  void logout() {
    emit(const LoginState.unauthenticated());
  }
}
