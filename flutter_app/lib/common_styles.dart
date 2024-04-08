import 'package:flutter/material.dart';
import 'package:flutter_app/constants/color_res.dart';
import 'package:flutter_app/utils/color_utils.dart';

Color colorByMode(BuildContext context, Color lightColor, Color darkColor) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return darkColor;
  } else {
    return lightColor;
  }
}

class CommonStyles {
  static TextStyle normalTextBlack(BuildContext context) {
    return TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        color: colorByMode(context, Colors.black87, Colors.white));
  }

  static TextStyle boldTextBlack(BuildContext context) {
    return TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w700,
        color: colorByMode(context, Colors.black87, Colors.white));
  }

  static TextStyle size16Black700(BuildContext context) {
    return TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        color: colorByMode(context, Colors.black87, Colors.white));
  }

  static TextStyle size16Black700Inter(BuildContext context) {
    return const TextStyle(
        fontSize: 16.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        color: ColorRes.black);
  }

  static TextStyle size16Black600Inter(BuildContext context) {
    return const TextStyle(
        fontSize: 16.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        color: ColorRes.black);
  }

  static TextStyle size15White700(BuildContext context) {
    return const TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.w700, color: Colors.white);
  }

  static TextStyle size15Black700(BuildContext context) {
    return const TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.w700, color: Colors.black);
  }

  static TextStyle size12Black600(BuildContext context) {
    return const TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.black);
  }

  static TextStyle size12Gray600(BuildContext context) {
    return TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        color: Colors.black.withOpacity(0.5));
  }

  static TextStyle size14Black600(BuildContext context) {
    return const TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black);
  }

  static TextStyle size14c037AA5w600(BuildContext context) {
    return TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: HexColor('#037AA5'));
  }

  static TextStyle size14Red600(BuildContext context) {
    return const TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xffFF3B30));
  }

  static TextStyle size14White600(BuildContext context) {
    return const TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white);
  }

  static TextStyle size14White400(BuildContext context) {
    return const TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white);
  }

  static TextStyle size10Black400(BuildContext context) {
    return const TextStyle(
        fontSize: 10.0, fontWeight: FontWeight.w400, color: Color(0xff000000));
  }

  static TextStyle size10Black600(BuildContext context) {
    return const TextStyle(
        fontSize: 10.0, fontWeight: FontWeight.w600, color: Color(0xff000000));
  }

  static TextStyle size9Black400(BuildContext context) {
    return const TextStyle(
        fontSize: 9.0, fontWeight: FontWeight.w400, color: Color(0xff000000));
  }

  static TextStyle size8Gray400(BuildContext context) {
    return const TextStyle(
        fontSize: 8.0, fontWeight: FontWeight.w400, color: Color(0xffB1B1B1));
  }

  static TextStyle size8White600(BuildContext context) {
    return const TextStyle(
        fontSize: 8.0, fontWeight: FontWeight.w600, color: Color(0xffFFFFFF));
  }

  static TextStyle size10Gray400(BuildContext context) {
    return const TextStyle(
        fontSize: 10.0, fontWeight: FontWeight.w400, color: Color(0xff939393));
  }

  static TextStyle size10White400(BuildContext context) {
    return const TextStyle(
        fontSize: 10.0, fontWeight: FontWeight.w400, color: Color(0xffFFFFFF));
  }

  static TextStyle size10cA0A0A0w400(BuildContext context) {
    return const TextStyle(
        fontSize: 10.0, fontWeight: FontWeight.w400, color: Color(0xffA0A0A0));
  }

  static TextStyle size12Black400(BuildContext context) {
    return const TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.black);
  }

  static TextStyle size12White400(BuildContext context) {
    return const TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.white);
  }

  static TextStyle size22White400(BuildContext context) {
    return const TextStyle(
        fontSize: 22.0, fontWeight: FontWeight.w400, color: Colors.white);
  }

  static TextStyle size12Gray400(BuildContext context) {
    return const TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w400, color: Color(0xff9F9F9F));
  }

  static TextStyle size12c81w400(BuildContext context) {
    return const TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w400, color: Color(0xff818181));
  }

  static TextStyle size12c93w600(BuildContext context) {
    return const TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w600, color: Color(0xff939393));
  }

  static TextStyle size12c81w400Inter(BuildContext context) {
    return const TextStyle(
        fontFamily: 'Inter',
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        color: Color(0xff818181));
  }

  static TextStyle size12cA3w400(BuildContext context) {
    return const TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w400, color: Color(0xffA3A3A3));
  }

  static TextStyle size12White600(BuildContext context) {
    return const TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.white);
  }

  static TextStyle size16Black400(BuildContext context) {
    return const TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black);
  }

  static TextStyle size16White600(BuildContext context) {
    return const TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white);
  }

  static TextStyle size16Black600(BuildContext context) {
    return const TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: ColorRes.black);
  }

  static TextStyle size12Cyan600(BuildContext context) {
    return const TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w600, color: Color(0xff15A7D6));
  }

  static TextStyle size10White600(BuildContext context) {
    return const TextStyle(
        fontSize: 10.0, fontWeight: FontWeight.w600, color: Colors.white);
  }

  static TextStyle size50Black400(BuildContext context) {
    return const TextStyle(
        fontSize: 50.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'Road Rage',
        color: Colors.black);
  }

  static TextStyle size40Black400(BuildContext context) {
    return const TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'Road Rage',
        color: Colors.black);
  }

  static TextStyle size40Black400Poppins(BuildContext context) {
    return const TextStyle(
        fontSize: 40.0, fontWeight: FontWeight.w400, color: Colors.black);
  }

  static TextStyle size30Black400(BuildContext context) {
    return const TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'Road Rage',
        color: Colors.black);
  }

  static TextStyle size15Gray400(BuildContext context) {
    return const TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.w400, color: Color(0xff5E5E5E));
  }

  static TextStyle s15c393939w400(BuildContext context) {
    return const TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.w400, color: Color(0xff393939));
  }

  static TextStyle size14Gray400(BuildContext context) {
    return const TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: Color(0xff4D4D4D));
  }

  static TextStyle size14c4Aw400(BuildContext context) {
    return const TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: Color(0xff4A4A4A));
  }

  static TextStyle size14a9w400(BuildContext context) {
    return const TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: Color(0xffA9A9A9));
  }

  static TextStyle s14c8D8D8Dw400(BuildContext context) {
    return const TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: Color(0xff8D8D8D));
  }

  static TextStyle size14G8Bw400(BuildContext context) {
    return const TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: Color(0xff8B8B8B));
  }

  static TextStyle size14Black400(BuildContext context) {
    return const TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: ColorRes.black);
  }

  static TextStyle size14Black400Inter(BuildContext context) {
    return const TextStyle(
        fontFamily: 'Inter',
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: ColorRes.black);
  }

  static TextStyle size18Black600(BuildContext context) {
    return const TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: ColorRes.black);
  }

  static TextStyle size30Black600(BuildContext context) {
    return const TextStyle(
        fontSize: 30.0, fontWeight: FontWeight.w600, color: ColorRes.black);
  }

  static TextStyle size20Black600(BuildContext context) {
    return const TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: ColorRes.black);
  }

  static TextStyle size20Black700(BuildContext context) {
    return const TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.w700, color: ColorRes.black);
  }

  static TextStyle size13Black600(BuildContext context) {
    return const TextStyle(
        fontSize: 13.0, fontWeight: FontWeight.w600, color: ColorRes.black);
  }

  static TextStyle size13White400(BuildContext context) {
    return const TextStyle(
        fontSize: 13.0, fontWeight: FontWeight.w400, color: ColorRes.white);
  }

  static TextStyle size13Black400(BuildContext context) {
    return const TextStyle(
        fontSize: 13.0, fontWeight: FontWeight.w400, color: ColorRes.black);
  }

  static TextStyle size18Black400Quantico(BuildContext context) {
    return const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'Quantico',
        color: ColorRes.black);
  }

  static TextStyle size11Black400(BuildContext context) {
    return const TextStyle(
        fontSize: 11.0, fontWeight: FontWeight.w400, color: ColorRes.black);
  }

  static TextStyle size30Black700(BuildContext context) {
    return const TextStyle(
        fontSize: 30.0, fontWeight: FontWeight.w700, color: Colors.black);
  }

  static TextStyle size30Black700Road(BuildContext context) {
    return const TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
      fontFamily: 'Road Rage',
    );
  }

  static TextStyle size12Black700(BuildContext context) {
    return const TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w700, color: ColorRes.black);
  }

  static TextStyle size20Black400(BuildContext context) {
    return const TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.w400, color: ColorRes.black);
  }
}
