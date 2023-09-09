import 'dart:async';

class FoxLocationUpdateStream {
  final _socketResponse = StreamController<String>.broadcast();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;
}

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

AreaStatusUpdateStream areaStatusUpdateStream = AreaStatusUpdateStream();
FoxLocationUpdateStream foxLocationUpdateStream = FoxLocationUpdateStream();
FoxLocationUpdateSingleAreaStream foxLocationUpdateSingleAreaStream =
    FoxLocationUpdateSingleAreaStream();
