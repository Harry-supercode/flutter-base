import 'package:flutter/material.dart';
import 'package:flutter_app/components/divider_widget.dart';
import 'package:flutter_app/screens/auth/signup/components/base_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sprintf/sprintf.dart';
import 'package:flutter_app/blocs/auth/auth_bloc.dart';
import 'package:flutter_app/blocs/auth/auth_events.dart';
import 'package:flutter_app/blocs/auth/auth_states.dart';
// import 'package:flutter_app/components/common_bottom_sheet/bottom_sheet_widget.dart';
// import 'package:flutter_app/components/common_input.dart';
// import 'package:flutter_app/components/date_picker/select_date_spinner.dart';
// import 'package:flutter_app/components/divider_widget.dart';
// import 'package:flutter_app/components/gradient_button.dart';
// import 'package:flutter_app/components/gradient_text.dart';
// import 'package:flutter_app/components/upper_content_auth.dart';
import 'package:flutter_app/constants/color_res.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/constants/message_constants.dart';
import 'package:flutter_app/extensions/context_ext.dart';
import 'package:flutter_app/extensions/style_ext.dart';
// import 'package:flutter_app/models/common/country_model.dart';
// import 'package:flutter_app/screens/auth/signup/components/base_app_bar.dart';
// import 'package:flutter_app/screens/auth/signup/setup_second_screen.dart';
// import 'package:flutter_app/screens/auth/signup/terms_conditions_widget.dart';
import 'package:flutter_app/shared_pref_services.dart';
import 'package:flutter_app/utils/color_utils.dart';

class SetUpFirstScreen extends StatefulWidget {
  /// If userInfo != null, register account social
  final Map<String, dynamic>? userInfo;
  final String? email;

  const SetUpFirstScreen({super.key, this.userInfo, this.email});

  @override
  State<SetUpFirstScreen> createState() => _SetUpFirstScreenState();
}

class _SetUpFirstScreenState extends State<SetUpFirstScreen> {
  // Reveal password flag
  final bool _isReveal = false;

  // list validate
  final List<String> _validateList = [];

  // list Gender
  // final List<ItemCommonBottomSheet> _genderList = [
  //   ItemCommonBottomSheet(value: 'Male', id: 'male'),
  //   ItemCommonBottomSheet(value: 'Female', id: 'female'),
  //   ItemCommonBottomSheet(value: 'LGBTQ+', id: 'lgbt')
  // ];

  // List countries name
  // final List<ItemCommonBottomSheet> _countries = [];

  // List countries code
  // final List<ItemCommonBottomSheet> _countriesCode = [];

  // Check empty gender, birthday, country
  bool _isEmptyGender = false, _isEmptyCountry = false;

  // Check valid next
  final bool _isValidNext = false;

  /// ================================================
  /// ================== [FUNCTIONS] =================
  /// ================================================

  // validate password
  _validatePassword(String value) {
    _validateList.clear();
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      _validateList.add('1_lowercase');
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      _validateList.add('1_uppercase');
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      _validateList.add('1_number');
    }
    if (value.length < 8) {
      _validateList.add('at_least_8_chars');
    }
    if (value.length > 50) {
      _validateList.add('The maximum character length is 50 characters');
    }
    context.read<AuthBloc>().add(const CheckValidFieldSetupAccount());
  }

  // Setup info when login social
  _setInfo() {
    final setupModel = context.read<AuthBloc>().setupAccountModel;
    if (widget.userInfo != null) {
      setupModel.firstNameController?.text = widget.userInfo?['name'] ?? '';
      setupModel.lastNameController?.text = widget.userInfo?['last_name'] ?? '';
    }
    if (widget.email != null) {
      setupModel.emailController?.text = widget.email ?? '';
    }

    setupModel.isSocial = widget.userInfo != null;
    setState(() {});
  }

  // Setup data country & phone code
  // _setupCountry() {
  //   _countriesCode.clear();
  //   _countries.clear();
  //   final listDataCountryBE =
  //       context.read<CommonBloc>().state.listCountries ?? <CountryModel>[];

  //   for (var countryModel in listDataCountryBE) {
  //     _countries.add(ItemCommonBottomSheet(
  //         value: countryModel.name ?? '', id: countryModel.id));

  //     _countriesCode.add(ItemCommonBottomSheet(
  //         value: '${countryModel.name} (+${countryModel.phoneCode})',
  //         id: countryModel.id));
  //   }
  //   setState(() {});
  // }

  // Move to next step
  _moveToStepII(BuildContext context) {
    context
        .read<AuthBloc>()
        .add(CheckPhoneExisting(time: DateTime.now().millisecondsSinceEpoch));
  }

  // change gender
  // _handleChangeGender(BuildContext context) async {
  //   await DialogUtils.showBottomSheetRadio(
  //       context: context,
  //       child: CommonBottomSheetBool(
  //         title: 'gender',
  //         listItem: _genderList,
  //         initValue: context.read<AuthBloc>().setupAccountModel.gender?.id,
  //         selectItem: (e) {
  //           _isEmptyGender = false;
  //           context.read<AuthBloc>().setupAccountModel.gender =
  //               GenderModel(value: e.value, id: e.id);
  //           context.read<AuthBloc>().add(const CheckValidFieldSetupAccount());
  //         },
  //       ));

  //   if (context.read<AuthBloc>().setupAccountModel.gender == null) {
  //     setState(() {
  //       _isEmptyGender = true;
  //     });
  //   }
  // }

  // change country code
  _handleChangeCountry(BuildContext context) async {
    // await DialogUtils.showBottomSheetRadio(
    //     context: context,
    //     child: CommonBottomSheetBool(
    //       isVisibleSearch: true,
    //       title: 'country',
    //       initValue:
    //           context.read<AuthBloc>().setupAccountModel.country?.id.toString(),
    //       listItem: _countries,
    //       selectItem: (value) {
    //         _isEmptyCountry = false;
    //         final listDataCountryBE =
    //             context.read<CommonBloc>().state.listCountries ??
    //                 <CountryModel>[];
    //         final countryModel = listDataCountryBE
    //             .firstWhere((element) => element.id == value.id);
    //         context.read<AuthBloc>().setupAccountModel.country = countryModel;
    //         context.read<AuthBloc>().add(const CheckValidFieldSetupAccount());
    //       },
    //     ));

    // if (context.read<AuthBloc>().setupAccountModel.country == null) {
    //   setState(() {
    //     _isEmptyCountry = true;
    //   });
    // }
  }

  // change country code
  _handleChangeCountryCode(BuildContext context) {
    // DialogUtils.showBottomSheetRadio(
    //     context: context,
    //     child: CommonBottomSheetBool(
    //       isVisibleSearch: true,
    //       title: 'country_code',
    //       listItem: _countriesCode,
    //       initValue: context.read<AuthBloc>().setupAccountModel.phoneCodeId,
    //       selectItem: (value) {
    //         context.read<AuthBloc>().setupAccountModel.phoneCode =
    //             value.value?.split('+')[1].replaceAll(')', '');
    //         context.read<AuthBloc>().setupAccountModel.phoneCodeId =
    //             value.id.toString();
    //         context.read<AuthBloc>().add(const CheckValidFieldSetupAccount());
    //       },
    //     ));
  }

  _fillData() {
    // _setupCountry();
    _setInfo();
  }

  // Display permission access images
  _accessImagesPermission() async {
    final pref = await SharedPreferencesService.instance;
    final state = await PhotoManager.requestPermissionExtend();
    debugPrint('Permission State: $state');
    pref.setIsAccessLimited(state == PermissionState.limited);
  }

  @override
  void initState() {
    context.read<AuthBloc>().add(InitialModel());
    _accessImagesPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: BaseAppBar(
          type: AppBarType.step,
          appBar: AppBar(),
          currentStep: Constant.stepI,
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // MARK: Upper content
                      // const UpperContentAuth(
                      //     title: 'setup_account',
                      //     content: 'tell_us_something_about_yourself'),
                      // MARK: Input form
                      // MARK: Input form
                      _inputForm(context)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Upper content
  Widget _inputForm(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthStates>(
      listener: (context, state) {
        if (state is SetupModelSuccess) {
          _fillData();
        }
        // else if (state is NextPageAuth) {
        //   Navigator.push(context,
        //       MaterialPageRoute(builder: (_) => const SetupSecondScreen()));
        // }
      },
      builder: (context, state) {
        final setupModel = context.read<AuthBloc>().setupAccountModel;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Visibility(
                  visible: widget.email != null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CommonInput(
                      //   isEnabledRequire: true,
                      //   isPaddingLeft: true,
                      //   controller: setupModel.emailController ??
                      //       TextEditingController(),
                      //   title: context.translate('email'),
                      //   fieldName: context.translate('email'),
                      //   isCheckValidate: true,
                      //   isEnabled: setupModel.emailController == null ||
                      //       (setupModel.emailController?.text ?? Constant.empty)
                      //           .isEmpty,
                      // ),
                      const SizedBox(
                        height: 14,
                      ),
                      // Visibility(
                      //   visible: widget.userInfo == null,
                      //   child: CommonInput(
                      //       isEnabledRequire: true,
                      //       controller: setupModel.passwordController ??
                      //           TextEditingController(),
                      //       isPaddingLeft: true,
                      //       isCheckValidate: true,
                      //       fieldName:
                      //           context.translate('password').toLowerCase(),
                      //       isPassword: !_isReveal,
                      //       onChanged: (value) {
                      //         setState(() {
                      //           _validatePassword(value);
                      //         });
                      //       },
                      //       onCheckValue: (value) {
                      //         if (_validateList.isNotEmpty) {
                      //           return MessageConstants.mgs2;
                      //         }
                      //       },
                      //       title: context.translate('password'),
                      //       suffixWidget: IconButton(
                      //           onPressed: () {
                      //             setState(() {
                      //               _isReveal = !_isReveal;
                      //             });
                      //           },
                      //           icon: Image.asset(
                      //             _isReveal
                      //                 ? 'assets/icons/ic_reveal.png'
                      //                 : 'assets/icons/ic_hide.png',
                      //             width: 21,
                      //             height: 21,
                      //           ))),
                      // ),
                      // const SizedBox(height: 6),
                      Visibility(
                        visible: _validateList.isNotEmpty,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              _validateList.length,
                              (index) => Text(
                                  context.translate(_validateList[index]))),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: DividerCommon(),
                      ),
                    ],
                  ),
                ),
                // CommonInput(
                //   isEnabledRequire: true,
                //   key: const ValueKey('firstNm'),
                //   controller:
                //       setupModel.firstNameController ?? TextEditingController(),
                //   isPaddingLeft: true,
                //   title: context.translate('first_name'),
                //   isCheckValidate: true,
                //   onChanged: (value) {
                //     context
                //         .read<AuthBloc>()
                //         .add(const CheckValidFieldSetupAccount());
                //   },
                //   onCheckValue: (value) {
                //     if (value.trim().length > 50) {
                //       return sprintf(MessageConstants.mgs7, [50]);
                //     }
                //   },
                //   fieldName: context.translate('first_name').toLowerCase(),
                // ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  // child: CommonInput(
                  //   isEnabledRequire: true,
                  //   key: const ValueKey('lastNm'),
                  //   isPaddingLeft: true,
                  //   onChanged: (value) {
                  //     context
                  //         .read<AuthBloc>()
                  //         .add(const CheckValidFieldSetupAccount());
                  //   },
                  //   controller: setupModel.lastNameController ??
                  //       TextEditingController(),
                  //   onCheckValue: (value) {
                  //     if (value.trim().length > 50) {
                  //       return sprintf(MessageConstants.mgs7, [50]);
                  //     }
                  //   },
                  //   isCheckValidate: true,
                  //   title: context.translate('last_name'),
                  //   fieldName: context.translate('last_name').toLowerCase(),
                  // ),
                ),
                // _buildSelectWidget(context, setupModel.gender?.value ?? '',
                //     'gender', () => _handleChangeGender(context),
                //     isEmpty: _isEmptyGender),
                // SelectDateSpinner(
                //     isEnabledRequire: true,
                //     title: context.translate('birthday'),
                //     datePicker: (value) {
                //       setupModel.birthDay = '${value.split('-').first}-01-01';
                //       context
                //           .read<AuthBloc>()
                //           .add(const CheckValidFieldSetupAccount());
                //       print(setupModel.birthDay);
                //     },
                //     typeDatePicker: CupertinoDatePickerMode.date,
                //     urlImage: 'assets/icons/ic_calendar.svg'),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 21),
                  child: DividerCommon(),
                ),
                // _buildSelectWidget(context, setupModel.country?.name ?? '',
                //     'country', () => _handleChangeCountry(context),
                //     isEmpty: _isEmptyCountry),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: context.translate('phone_number'),
                            style: context.size12Black600),
                        // TextSpan(
                        //     text: '*',
                        //     style: context.size14Black600
                        //         .copyWith(color: HexColor('#F1034A')))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () => _handleChangeCountryCode(context),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: ColorRes.normalBorder)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '+${setupModel.phoneCode}',
                                  style: context.size14Black400,
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  size: 24,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            // child: CommonInput(
                            //   key: const ValueKey('phoneNumber'),
                            //   isCheckValidate: false,
                            //   fieldName: 'phone number',
                            //   textInputType: TextInputType.number,
                            //   onCheckValue: (value) {
                            //     final valid = value.trim().length <= 13 &&
                            //         value.trim().length >= 8;
                            //     if (!valid) {
                            //       return MessageConstants.mgs5;
                            //     }
                            //   },
                            //   onChanged: (value) {
                            //     context
                            //         .read<AuthBloc>()
                            //         .add(const CheckValidFieldSetupAccount());
                            //   },
                            //   controller: setupModel.phoneController ??
                            //       TextEditingController(),
                            // ),
                          ),
                          SizedBox(
                            height: 12,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(
                                    width: 1.0, color: ColorRes.checkboxBorder),
                              ),
                              value: setupModel.agree,
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                              onChanged: (value) {
                                setupModel.agree = value as bool;
                                context
                                    .read<AuthBloc>()
                                    .add(const CheckValidFieldSetupAccount());
                              }),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        context.translate('i_agree_to_the'),
                        style: context.size12Black400,
                      ),
                      // GradientText(
                      //     onTap: () async {
                      //       final result = await kOpenPage(
                      //           context, const TermsConditionsScreen());
                      //       if (result != null) {
                      //         setupModel.agree = true;
                      //         context
                      //             .read<AuthBloc>()
                      //             .add(const CheckValidFieldSetupAccount());
                      //       }
                      //     },
                      //     text: context.translate('terms_and_condition'))
                    ],
                  ),
                ),
                // BlocConsumer<AuthBloc, AuthStates>(
                //   listener: (context, state) {
                //     if (state is ValidNextStep) {
                //       _isValidNext = state.isValid;
                //     }
                //   },
                //   builder: (context, state) {
                //     return GradientButton(
                //         margin: const EdgeInsets.only(top: 40),
                //         content: context.translate('next'),
                //         onPressed:
                //             _isValidNext ? () => _moveToStepII(context) : null);
                //   },
                //   buildWhen: (pre, cur) => cur is ValidNextStep,
                // ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        );
      },
      buildWhen: (pre, cur) => cur is SetupModelSuccess || cur is ValidNextStep,
    );
  }

  // build select widget
  Widget _buildSelectWidget(
      BuildContext context, String value, String title, Function() function,
      {bool? isEmpty}) {
    return GestureDetector(
      onTap: function,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: context.translate(title),
                      style: context.size12Black600),
                  TextSpan(
                      text: '*',
                      style: context.size14Black600
                          .copyWith(color: HexColor('#F1034A')))
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: ColorRes.normalBorder)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title != 'phone_number' ? value : '+$value',
                    style: context.size14Black400,
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    size: 24,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: isEmpty ?? false,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                sprintf(MessageConstants.mgs1,
                    [context.translate(title).toLowerCase()]),
                style: context.size12Black600.copyWith(color: Colors.red),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class ValidateFieldModel {
  String? firstName;
  String? lastName;
  String? phoneNumber;

  ValidateFieldModel({this.firstName, this.lastName, this.phoneNumber});
}
