import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:juna_bhajan/data/model/user.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
}

class LoadInitialSettingDataEvent extends SettingEvent {
  const LoadInitialSettingDataEvent();

  @override
  List<Object?> get props => [];
}

class GoogleLoginSettingDataEvent extends SettingEvent {
  const GoogleLoginSettingDataEvent();

  @override
  List<Object?> get props => [];
}

class GoogleLoginOutSettingDataEvent extends SettingEvent {
  const GoogleLoginOutSettingDataEvent();

  @override
  List<Object?> get props => [];
}

class GoogleAuthChangeSettingDataEvent extends SettingEvent {
  final UserData? user;

  const GoogleAuthChangeSettingDataEvent({
    required this.user,
  });

  @override
  List<Object?> get props => [
        user,
      ];
}

class ChangeThemeDataEvent extends SettingEvent {
  final ThemeMode themeMode;

  const ChangeThemeDataEvent({required this.themeMode});

  @override
  List<Object?> get props => [themeMode];
}

class SaveFontSettingDataEvent extends SettingEvent {
  const SaveFontSettingDataEvent();

  @override
  List<Object?> get props => [];
}

class ChangeFontSizeEvent extends SettingEvent {
  final double fontSize;

  const ChangeFontSizeEvent({required this.fontSize});

  @override
  List<Object?> get props => [fontSize];
}

class ChangeFontFamilyEvent extends SettingEvent {
  final String fontFamily;

  const ChangeFontFamilyEvent({required this.fontFamily});

  @override
  List<Object?> get props => [fontFamily];
}

class ChangeFontBrightnessEvent extends SettingEvent {
  final double fontBrightness;

  const ChangeFontBrightnessEvent({required this.fontBrightness});

  @override
  List<Object?> get props => [fontBrightness];
}

class ChangeFontWeightEvent extends SettingEvent {
  final double fontWeight;

  const ChangeFontWeightEvent({required this.fontWeight});

  @override
  List<Object?> get props => [fontWeight];
}