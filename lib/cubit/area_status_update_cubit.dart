import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AreaStatusUpdateObserver {
  void updateState(bool shouldUpdate);
}

class AreaStatusUpdateCubit extends Cubit<bool> {
  final List<AreaStatusUpdateObserver> _observers = [];
  AreaStatusUpdateCubit() : super(false);

  void addObserver(AreaStatusUpdateObserver observer) {
    _observers.add(observer);
  }

  void _notifyObservers(bool shouldUpdate) {
    for (var observer in _observers) {
      observer.updateState(shouldUpdate);
    }
  }

  void needUpdate() {
    _notifyObservers(true);
    emit(true);
  }

  void doenstNeedUpdate() {
    emit(false);
    _notifyObservers(false);
  }
}
