import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jotihunt/cubit/login_state.dart';
import 'package:jotihunt/handlers/handler_streamsocket.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState.unauthenticated());

  Socket socket = io(
      dotenv.env['API_ROOT'],
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build());

  void login() {
    emit(const LoginState.authenticated());
    socket.connect();
    socket.on('foxlocation', (data) async {
      print(data + "socket message recived");
      streamSocket.addResponse(data.toString());
    });
  }

  void logout() {
    emit(const LoginState.unauthenticated());
    socket.disconnect();
  }
}
