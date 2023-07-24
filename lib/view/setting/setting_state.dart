import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:juna_bhajan/data/model/user.dart';

class SettingState extends Equatable {
  final ThemeMode themeMode;
  final double fontSize;
  final String fontFamily;
  final double fontBrightness;
  final int fontWeight;
  final String appVersionName;
  final int currentAppVersion;
  final bool isLoading;
  final String error;
  final UserData? user;

  const SettingState({
    required this.themeMode,
    required this.fontSize,
    required this.fontFamily,
    required this.fontBrightness,
    required this.fontWeight,
    required this.currentAppVersion,
    required this.appVersionName,
    required this.isLoading,
    required this.error,
    required this.user,
  });

  factory SettingState.initial() => const SettingState(
        themeMode: ThemeMode.light,
        fontSize: 18,
        fontFamily: "Rasa",
        fontBrightness: 10,
        fontWeight: 8,
        currentAppVersion: 8,
        appVersionName: "",
        isLoading: false,
        error: "",
        user: null,
      );

  SettingState copyWith({
    ThemeMode? themeMode,
    double? fontSize,
    String? fontFamily,
    double? fontBrightness,
    int? fontWeight,
    String? appVersionName,
    int? currentAppVersion,
    bool? isLoading,
    String? error,
  }) =>
      SettingState(
        themeMode: themeMode ?? this.themeMode,
        fontSize: fontSize ?? this.fontSize,
        fontFamily: fontFamily ?? this.fontFamily,
        fontBrightness: fontBrightness ?? this.fontBrightness,
        fontWeight: fontWeight ?? this.fontWeight,
        appVersionName: appVersionName ?? this.appVersionName,
        currentAppVersion: currentAppVersion ?? this.currentAppVersion,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        user: user,
      );

  SettingState copyUser({
    UserData? user,
  }) =>
      SettingState(
        themeMode: themeMode,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontBrightness: fontBrightness,
        fontWeight: fontWeight,
        appVersionName: appVersionName,
        currentAppVersion: currentAppVersion,
        isLoading: isLoading,
        error: error,
        user: user,
      );

  @override
  List<Object?> get props => [
        themeMode,
        fontSize,
        fontWeight,
        fontBrightness,
        fontFamily,
        appVersionName,
        currentAppVersion,
        isLoading,
        error,
        user,
      ];
}
