import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jotihunt/cubit/login_state.dart';
import 'package:socket_io_client/socket_io_client.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState.unauthenticated());

  Socket socket = io(
      'http://localhost:3000',
      OptionBuilder().setTransports(['websocket']).setExtraHeaders(
          {'foo': 'bar'}).build());

  void login() {
    emit(const LoginState.authenticated());
    socket.connect();
  }

  void logout() {
    emit(const LoginState.unauthenticated());
    socket.disconnect();
  }
}
