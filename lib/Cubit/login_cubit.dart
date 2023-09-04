import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jotihunt/Cubit/login_state.dart';
import 'package:jotihunt/handlers/handler_streamsocket.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState.unauthenticated());

  SocketConnection socket = SocketConnection();

  void login() {
    emit(const LoginState.authenticated());
    socket.connectSocket();
  }

  void logout() {
    emit(const LoginState.unauthenticated());
    // socket.disconnect();
  }
}
