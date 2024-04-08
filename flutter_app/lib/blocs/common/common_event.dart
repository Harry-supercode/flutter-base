import 'package:equatable/equatable.dart';

abstract class CommonEvent extends Equatable {}

class GetListDataCommonEvent extends CommonEvent {
  @override
  List<Object?> get props => [];
}

class RequestChangeTab extends CommonEvent {
  final int position;
  final Map<String, dynamic>? map;
  RequestChangeTab({required this.position, this.map});
  @override
  List<Object?> get props => [position, map];
}
