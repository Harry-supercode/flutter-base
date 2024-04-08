import 'package:equatable/equatable.dart';

abstract class TeamsEvent extends Equatable {
  const TeamsEvent();
  @override
  List<Object?> get props => [];
}

class RequestGetMyTeamEvent extends TeamsEvent {}

class GetTeamProfileEvent extends TeamsEvent {
  final int id;

  const GetTeamProfileEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

// teamLeave
class RequestTeamLeave extends TeamsEvent {
  final int id;

  const RequestTeamLeave({required this.id});
}

class GetListLevelEvent extends TeamsEvent {
  const GetListLevelEvent();

  @override
  List<Object?> get props => [];
}

class TeamProfileUpdateEvent extends TeamsEvent {
  final int id;
  final Map<String, dynamic> payload;

  const TeamProfileUpdateEvent({required this.payload, required this.id});

  @override
  List<Object?> get props => [payload, id];
}

class RequestUpdateMemberStatus extends TeamsEvent {
  final int teamId;
  final int memberId;
  final Map map;

  const RequestUpdateMemberStatus(
      {required this.teamId, required this.memberId, required this.map});

  @override
  List<Object?> get props => [teamId, memberId, map];
}
