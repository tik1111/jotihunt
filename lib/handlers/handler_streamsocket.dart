import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jotihunt/cubit/fox_location_update_cubit.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketConnection {
  void connectSocket(BuildContext context) {
    final cubit = context.read<FoxLocationUpdateCubit>();

    Socket socket = io(
        dotenv.env['API_ROOT'],
        OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNew()
            .enableAutoConnect()
            .build());
    socket.connect();

    socket.on('foxlocation', (data) {
      if (kDebugMode) {
        print(data + "socket message recived");
      }
      cubit.needUpdate();
    });
  }
}
