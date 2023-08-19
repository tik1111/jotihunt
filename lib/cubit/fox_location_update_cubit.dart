import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FoxLocationUpdateObserver {
  void updateState(bool shouldUpdate);
}

class FoxLocationUpdateCubit extends Cubit<bool> {
  final List<FoxLocationUpdateObserver> _observers = [];
  FoxLocationUpdateCubit() : super(false);

  void addObserver(FoxLocationUpdateObserver observer) {
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
