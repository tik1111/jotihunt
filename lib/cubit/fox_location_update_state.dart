import 'package:equatable/equatable.dart';

enum FoxStatus { unknown, uptodate, outofdate }

class FoxLocationUpdateState extends Equatable {
  FoxStatus status = FoxStatus.uptodate;

  FoxLocationUpdateState._({this.status = FoxStatus.unknown});

  FoxLocationUpdateState.uptodate() : this._(status: FoxStatus.uptodate);
  FoxLocationUpdateState.outofdate() : this._(status: FoxStatus.outofdate);

  @override
  List<Object?> get props => [status];
}
