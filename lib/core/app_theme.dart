import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juna_bhajan/core/app_colors.dart';
import 'package:juna_bhajan/core/constant.dart';

class ThemeController {
  static ThemeData lightTheme({required ProjectType projectType}) {
    final ThemeData base = ThemeData.light();
    TextTheme textTheme = projectType == ProjectType.junaBhajan
        ? GoogleFonts.hindVadodaraTextTheme(base.textTheme)
        : GoogleFonts.notoSansDevanagariTextTheme(base.textTheme);

    TextTheme buildTextThemeLight(TextTheme base) {
      return base.copyWith(
        displayLarge: textTheme.displayLarge,
        headlineSmall: textTheme.headlineSmall!
            .copyWith(fontWeight: FontWeight.bold, color: AppColor.black),
        titleLarge: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
        titleMedium: textTheme.titleMedium!.copyWith(color: AppColor.black),
        titleSmall: textTheme.titleSmall!
            .copyWith(color: AppColor.black, fontWeight: FontWeight.w700),
        bodyLarge: textTheme.bodyLarge!.copyWith(
          color: AppColor.blackLight,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: textTheme.bodyMedium!.copyWith(color: AppColor.blackLight),
        bodySmall: textTheme.bodySmall!.copyWith(color: AppColor.blackLight),
      );
    }

    return base.copyWith(
        primaryColor: Colors.red,
        indicatorColor: Colors.white,
        dividerColor: AppColor.lightDivider,
        // scaffoldBackgroundColor: Color(0xffe5e5e5),

        errorColor: AppColor.lightError,
        appBarTheme: base.appBarTheme.copyWith(
            color: const Color(0xccffffff),
            iconTheme: base.iconTheme.copyWith(color: AppColor.black)),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: AppColor.black),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            // replace default CupertinoPageTransitionsBuilder with this
            TargetPlatform.iOS: NoShadowCupertinoPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        dialogTheme: base.dialogTheme.copyWith(
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColor.blackLight),
            overlayColor:
                MaterialStateProperty.all(ThemeData.dark().splashColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(base.splashColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(color: AppColor.blackLight)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(AppColor.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.29),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
          ),
        ),
        inputDecorationTheme: base.inputDecorationTheme.copyWith(
          border: InputBorder.none,
          isDense: false,
          filled: true,
          fillColor: const Color(0xFFF1F1F1),
          hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColor.blackLight),
        ),
        cardTheme: CardTheme(
          color: const Color(0xfffcfcfc),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          elevation: 10,
          shadowColor: const Color(0xff000000).withOpacity(0.25),
        ),
        textTheme: buildTextThemeLight(base.textTheme));
  }

  static ThemeData darkTheme({required ProjectType projectType}) {
    final ThemeData base = ThemeData.dark();
    TextTheme textTheme = projectType == ProjectType.junaBhajan
        ? GoogleFonts.hindVadodaraTextTheme(base.textTheme)
        : GoogleFonts.notoSansDevanagariTextTheme(base.textTheme);

    TextTheme buildTextThemeDark(TextTheme base) {
      return base.copyWith(
        displayLarge: textTheme.displayLarge,
        headlineSmall: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
        titleLarge: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
        titleMedium: textTheme.titleMedium!.copyWith(color: AppColor.white),
        titleSmall: textTheme.titleSmall!
            .copyWith(color: AppColor.white, fontWeight: FontWeight.w700),
        bodyLarge: textTheme.bodyLarge!.copyWith(
          color: AppColor.whiteLight,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: textTheme.bodyMedium!.copyWith(color: AppColor.whiteLight),
        bodySmall: textTheme.bodySmall!.copyWith(color: AppColor.whiteLight),
      );
    }

    return base.copyWith(
        primaryColor: Colors.indigoAccent,
        indicatorColor: Colors.black,
        dividerColor: AppColor.darkDivider,
        appBarTheme: base.appBarTheme.copyWith(color: const Color(0xcc000000)),
        // scaffoldBackgroundColor: Color(0xff232323),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: AppColor.white),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            // replace default CupertinoPageTransitionsBuilder with this
            TargetPlatform.iOS: NoShadowCupertinoPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        dialogTheme: base.dialogTheme.copyWith(
          backgroundColor: Colors.black,
          elevation: 2,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColor.whiteLight),
            overlayColor:
                MaterialStateProperty.all(ThemeData.light().splashColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(base.splashColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(color: AppColor.whiteLight)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(AppColor.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.29),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
          ),
        ),
        inputDecorationTheme: base.inputDecorationTheme.copyWith(
            border: InputBorder.none,
            isDense: true,
            filled: true,
            fillColor: const Color(0xFF434343),
            hintStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColor.whiteLight)),
        cardTheme: CardTheme(
          color: const Color(0xff000000),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          elevation: 10,
          shadowColor: const Color(0xff000000).withOpacity(0.25),
        ),
        textTheme: buildTextThemeDark(base.textTheme));
  }
}
