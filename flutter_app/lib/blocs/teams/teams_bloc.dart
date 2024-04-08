
import 'package:flutter_app/blocs/base_bloc.dart';
// import 'package:flutter_app/blocs/profile/profile_bloc.dart';
// import 'package:flutter_app/blocs/profile/profile_event.dart';
import 'package:flutter_app/blocs/teams/teams_event.dart';
import 'package:flutter_app/blocs/teams/teams_state.dart';
// import 'package:flutter_app/models/team/organization_role_model.dart';
// import 'package:flutter_app/models/team/skill_level_model.dart';
// import 'package:flutter_app/models/team/team_model.dart';
// import 'package:flutter_app/services/team/team_repository.dart';
// import 'package:flutter_app/services/user/user_repository.dart';

class TeamsBloc extends BaseBlocCustom<TeamsEvent, TeamsState> {
  TeamsBloc() : super(UserInit()) {
    // get my team
    // on<RequestGetMyTeamEvent>(_handleGetMyTeam);

    // leave team
    // on<RequestTeamLeave>(_handleLeaveTeam);

    // get team profile
    // on<GetTeamProfileEvent>(_handleGetTeamProfile);

    // on<TeamProfileUpdateEvent>(_handleUpdateEvent);

    // on<RequestUpdateMemberStatus>(_handleUpdateStatusEvent);
  }

  // handle get my teams
  // _handleGetMyTeam(RequestGetMyTeamEvent event, Emitter emit) async {
  //   try {
  //     final result = await UserRepository.instance.getMyTeams();
  //     if (result != null) {
  //       emit(GetMyTeamSuccess(result));
  //     }
  //   } catch (e) {
  //     emit(GetMyTeamError(e.toString()));
  //   }
  // }
  // handle leave team
  // _handleLeaveTeam(RequestTeamLeave event, Emitter emit) async {
  //   emit(LeaveTeamLoading());
  //   try {
  //     final result = await UserRepository.instance.teamLeave(event.id);
  //     if (result == true) {
  //       emit(LeaveTeamSuccess());
  //     }
  //   } catch (e) {
  //     emit(LeaveTeamError(e.toString()));
  //   }
  // }

  // _handleGetTeamProfile(GetTeamProfileEvent event, Emitter emit) async {
  //   try {
  //     final result = await Future.wait([
  //       TeamRepository.instance.getTeamProfile(event.id),
  //       TeamRepository.instance.getListSkillLevel(),
  //       TeamRepository.instance.getListOrganizationRole()
  //     ]);
  //     if (result[0] != null && result[1] != null) {
  //       emit(GetTeamProfileSuccess(
  //           teamModel: result[0] as TeamModel,
  //           listSkills: result[1] as List<SkillLevelModel>,
  //           listRole: result[2] as List<OrganizationRoleModel>));
  //     } else {
  //       emit(const GetTeamProfileError("Failed"));
  //     }
  //   } catch (e) {
  //     emit(GetTeamProfileError(e.toString()));
  //   }
  // }

  // _handleUpdateEvent(TeamProfileUpdateEvent event, Emitter emit) async {
  //   try {
  //     final result = await TeamRepository.instance.updateProfileTeam(event.id, event.payload);
  //     if (result) {
  //       emit(UpdateProfileSuccess());
  //       add(GetTeamProfileEvent(id: event.id));
  //     }
  //   } catch (e) {
  //     emit(UpdateProfileError());
  //   }
  // }

  // _handleUpdateStatusEvent(RequestUpdateMemberStatus event, Emitter emit) async {
  //   try {
  //     final result = await TeamRepository.instance.updateMemberStatus(event.teamId, event.memberId, event.map);
  //     if (result) {
  //       emit(UpdateProfileSuccess());
  //       add(GetTeamProfileEvent(id: event.teamId));
  //       ProfileBloc().add(RequestGetTeamProfile(id: event.teamId));
  //     }
  //   } catch (e) {
  //     emit(UpdateProfileError());
  //   }
  // }
}
