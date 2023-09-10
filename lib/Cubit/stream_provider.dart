import 'dart:async';

class AreaStatusUpdateStream {
  final _socketResponse = StreamController<String>.broadcast();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;
}

class FoxLocationUpdateSingleAreaStream {
  final _socketResponse = StreamController<String>.broadcast();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;
}

class UserLocationUpdateStream {
  final _socketResponse = StreamController<String>.broadcast();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;
}

AreaStatusUpdateStream areaStatusUpdateStream = AreaStatusUpdateStream();
FoxLocationUpdateSingleAreaStream foxLocationUpdateSingleAreaStream =
    FoxLocationUpdateSingleAreaStream();
UserLocationUpdateStream userLocationUpdateStream = UserLocationUpdateStream();
