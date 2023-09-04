import 'package:flutter_bloc/flutter_bloc.dart';

class HuntTimeCubit extends Cubit<DateTime> {
  HuntTimeCubit() : super(DateTime.utc(2000, 1, 1));

  void updateHuntTime(DateTime newTime) {
    print(newTime);
    emit(newTime);
  }
}
