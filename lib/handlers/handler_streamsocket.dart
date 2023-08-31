import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:jotihunt/cubitAndStream/stream_provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketConnection {
  Socket? socket;

  void connectSocket() async {
    socket = io(
        dotenv.env['API_ROOT'],
        OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNew()
            .enableAutoConnect()
            .build());
    socket?.connect();

    socket?.on('foxlocation', (data) async {
      print(data + "socket message recived");
      foxLocationUpdateStream.addResponse(data.toString());
    });

    socket?.on('areastatus', (data) async {
      print(data + "socket message recived for aera");
      areaStatusUpdateStream.addResponse(data.toString());
    });
  }
}
