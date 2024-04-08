import 'package:equatable/equatable.dart';

abstract class TeamsState extends Equatable {
  const TeamsState();

  @override
  List<Object?> get props => [];
}

class UserInit extends TeamsState {}

/// [GetMyTeamSuccess] state
// class GetMyTeamSuccess extends TeamsState {
//   final DataTeams myTeamModel;

//   const GetMyTeamSuccess(this.myTeamModel);
//   @override
//   List<Object?> get props => [myTeamModel];
// }
/// [GetMyTeamSuccess] state
class GetMyTeamError extends TeamsState {
  final String message;

  const GetMyTeamError(this.message);

  @override
  List<Object?> get props => [message];
}

/// [GetTeamProfileSuccess] state
// class GetTeamProfileSuccess extends TeamsState {
//   final TeamModel teamModel;
//   final List<SkillLevelModel> listSkills;
//   final List<OrganizationRoleModel> listRole;

//   const GetTeamProfileSuccess({required this.teamModel, required this.listSkills, required this.listRole});

//   @override
//   List<Object?> get props => [teamModel, listSkills, listRole];
// }

/// [Leave Team Loading] state
class LeaveTeamLoading extends TeamsState {}

/// [Leave Team Success] state
class LeaveTeamSuccess extends TeamsState {
  @override
  List<Object?> get props => [];
}

/// [Leave Team Error] state
class LeaveTeamError extends TeamsState {
  final String message;
  const LeaveTeamError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetTeamProfileError extends TeamsState {
  final String message;
  const GetTeamProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateProfileSuccess extends TeamsState {}

class UpdateProfileError extends TeamsState {}
