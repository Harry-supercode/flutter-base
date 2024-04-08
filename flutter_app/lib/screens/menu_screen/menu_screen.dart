import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:flutter_app/blocs/profile/profile_bloc.dart';
// import 'package:flutter_app/blocs/profile/profile_state.dart';
// import 'package:flutter_app/components/daily_discover_components/daily_discover_avt.dart';
import 'package:flutter_app/constants/color_res.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/constants/global_constant.dart';
import 'package:flutter_app/extensions/context_ext.dart';
import 'package:flutter_app/extensions/style_ext.dart';
// import 'package:flutter_app/models/user/my_team_model.dart';
import 'package:flutter_app/models/user/user_model.dart';
// import 'package:flutter_app/screens/bookmark/book_mark_screen.dart';
// import 'package:flutter_app/screens/match/match_screen.dart';
// import 'package:flutter_app/screens/menu_screen/change_acount_screen.dart';
// import 'package:flutter_app/screens/my_teams/my_teams_screen.dart';
// import 'package:flutter_app/screens/palaro_event/palaro_event_screen.dart';
// import 'package:flutter_app/screens/settings/account_settings.dart';
// import 'package:flutter_app/screens/venues/venues_screen.dart';
import 'package:flutter_app/services/dio_client.dart';
// import 'package:flutter_app/services/social_services.dart';
import 'package:flutter_app/shared_pref_services.dart';

enum MenuType { teams, account, bookmark, matches, event, venue, logout }

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // User name
  String _userName = '', _avatar = '';

  // List team owner
  // List<Owned> _teams = [];

  // Version number
  String _version = Constant.empty;

  bool isAvatarOffensive = false;

  /// ================================================
  /// ================== [FUNCTIONS] =================
  /// ================================================

  // Handle navigate
  _handleNavigate(BuildContext context, MenuType type) {
    kPop(context);
    switch (type) {
      case MenuType.teams:
        _onTapTeams(context);
        break;
      case MenuType.account:
        _onTapAccountSettings(context);
        break;
      case MenuType.bookmark:
        _onTapBookmark(context);
        break;
      case MenuType.matches:
        _onTapMatches(context);
        break;
      case MenuType.event:
        _onTapEvents(context);
        break;
      case MenuType.venue:
        _onTapVenue(context);
        break;
      case MenuType.logout:
        DioClient.logOut();
        _onTapLogout(context);
        break;
    }
  }

  // Update data header
  _updateDataHeader(UserModel model) {
    setState(() {
      isAvatarOffensive = model.isAvatarOffensive ?? false;
      _avatar = model.avatar ?? Constant.empty;
      _userName = '${model.firstName ?? ''} ${model.lastName ?? ''}';
    });
  }

  // Teams handle
  _onTapTeams(BuildContext context) {
    //:TODO - Handle on click Teams
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (_) => const MyTeamsScreen()));
  }

  // Account settings handle
  _onTapAccountSettings(BuildContext context) {
    //:TODO - Handle on click account settings
    // kOpenPageSlide(context, const AccountSettings());
  }

  // Bookmark handle
  _onTapBookmark(BuildContext context) {
    //:TODO - Handle on click Bookmark
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (_) => const BookmarkScreen()));
  }

  // Matches handle
  _onTapMatches(BuildContext context) {
    // kOpenPage(context, const MatchScreen());
  }

  // Events handle
  _onTapEvents(BuildContext context) {
    //:TODO - Handle on click Events
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (_) => const PalaroEventScreen()));
  }

  // Venue handle
  _onTapVenue(BuildContext context) {
    //:TODO - Handle on click Venue
    // Navigator.of(context).pushNamed(VenuesScreen.route);
  }

  // Logout handle
  _onTapLogout(BuildContext context) async {
    //:TODO - Remove token or do something before logout
    /// Navigate to [AuthPage]
    // await SocialServices().signOut();
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (_) => const AuthPage()),
    //     (Route<dynamic> route) => false);
  }

  // handle Change Account
  _handleChangeAccount() {
    //:TODO- Handle settings event
    // DialogUtils.showCustomBottomSheet(
    //     context: context,
    //     padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
    //     child: ChangeAccount(
    //       userAvatar: _avatar,
    //       userName: _userName,
    //       teams: _teams,
    //       isOffensive: isAvatarOffensive,
    //     ));
  }

  // Get data from local
  _getDataFromLocal() async {
    final prefs = await SharedPreferencesService.instance;
    if (prefs.userProfile != null) {
      _userName =
          '${prefs.userProfile!.firstName ?? Constant.empty} ${prefs.userProfile!.lastName ?? Constant.empty}';
      _avatar = prefs.userProfile!.avatar ?? Constant.empty;
      isAvatarOffensive = prefs.userProfile?.isAvatarOffensive ?? false;
    }
    setState(() {});
  }

  // Get app info
  _getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionCd = packageInfo.version;
    _version = versionCd.toString();
    setState(() {});
  }

  @override
  void initState() {
    _getDataFromLocal();
    _getAppInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Config color system tray
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SizedBox(
        width: context.width * 0.8,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: Constant.mainGradient)),
            // child: Column(
            //   children: [
            //     _drawerHeader(context),
            //     Expanded(child: _menuListUI(context))
            //   ],
            // ),
          ),
        ),
      ),
    );
  }

  // Menu item
  Widget _menuItem(BuildContext context, MenuType type) {
    String icon;
    String menuName;
    switch (type) {
      case MenuType.teams:
        icon = 'ic_teams.svg';
        menuName = 'my_teams';
        break;
      case MenuType.account:
        icon = 'ic_account.svg';
        menuName = 'account_setting';
        break;
      case MenuType.bookmark:
        icon = 'ic_bookmark.svg';
        menuName = 'bookmark';
        break;
      case MenuType.matches:
        icon = 'ic_matches.svg';
        menuName = 'matches';
        break;
      case MenuType.event:
        icon = 'ic_event.svg';
        menuName = 'create_event';
        break;
      case MenuType.venue:
        icon = 'ic_booking.svg';
        menuName = 'book_a_venue';
        break;
      case MenuType.logout:
        icon = 'ic_signout.svg';
        menuName = 'logout';
        break;
    }
    return Material(
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 28),
        dense: true,
        leading: SvgPicture.asset(
          'assets/icons/$icon',
          width: 18,
          height: 18,
        ),
        title: Text(
          context.translate(menuName),
          style: context.size14Black600,
        ),
        onTap: () => _handleNavigate(context, type),
      ),
    );
  }

  // Drawer header
  // Widget _drawerHeader(BuildContext context) {
  //   return BlocListener<ProfileBloc, ProfileState>(
  //     listener: (context, state) {
  //       if (state is GetProfileSuccess) {
  //         print('Get::${state.userModel.firstName}');
  //         _updateDataHeader(state.userModel);
  //       } else if (state is UpdateProfileSuccess) {
  //         print('${state.userModel.firstName}');
  //         _updateDataHeader(state.userModel);
  //       }
  //     },
  //     child: Stack(
  //       clipBehavior: Clip.none,
  //       fit: StackFit.passthrough,
  //       children: [
  //         BlocListener<teams.TeamsBloc, teams.TeamsState>(
  //           listener: (context, state) {
  //             if (state is teams.GetMyTeamSuccess) {
  //               _teams = state.myTeamModel.owned ?? [];
  //             }
  //           },
  //           child: SizedBox(
  //             height: context.height * 0.23,
  //             child: IntrinsicHeight(
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 26),
  //                 child: InkWell(
  //                   onTap: () => _handleChangeAccount(),
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Container(
  //                         decoration: BoxDecoration(
  //                             shape: BoxShape.circle,
  //                             border:
  //                                 Border.all(color: Colors.white, width: 2)),
  //                         child: DailyAvatar(
  //                           type: DailyAvtType.onlyImg,
  //                           imageSrc: _avatar,
  //                           size: 60,
  //                           isOffensive: isAvatarOffensive,
  //                         ),
  //                       ),
  //                       Expanded(
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(left: 20.0),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               Text(
  //                                 _userName,
  //                                 style: context.size14White600,
  //                                 maxLines: 2,
  //                                 overflow: TextOverflow.ellipsis,
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                       const Icon(
  //                         Icons.arrow_drop_down,
  //                         color: Colors.white,
  //                         size: 20,
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //             bottom: -60,
  //             left: -16,
  //             right: 0,
  //             child: Image.asset(
  //               'assets/icons/ic_white_bg2.png',
  //               fit: BoxFit.fill,
  //             ))
  //       ],
  //     ),
  //   );
  // }

  // Build menu list
  Widget _menuListUI(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                // Menu list
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: _menuItem(context, MenuType.account),
                ),
                _menuItem(context, MenuType.teams),
                const Padding(
                  padding: EdgeInsets.only(top: 24, bottom: 24),
                  child: Divider(
                    color: ColorRes.divider,
                    height: 1,
                  ),
                ),
                _menuItem(context, MenuType.bookmark),
                _menuItem(context, MenuType.matches),
                const Padding(
                  padding: EdgeInsets.only(top: 24.0, bottom: 24),
                  child: Divider(
                    color: ColorRes.divider,
                    height: 1,
                  ),
                ),
                _menuItem(context, MenuType.event),
                _menuItem(context, MenuType.venue),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Divider(
                          color: ColorRes.divider,
                          height: 1,
                        ),
                      ),
                      _menuItem(context, MenuType.logout),
                      const SizedBox(
                        height: 34,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
