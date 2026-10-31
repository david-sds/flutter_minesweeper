import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/app/theme.dart';
import 'package:mobx/mobx.dart';

part 'system_configuration_module.g.dart';

class SystemConfigurationModule extends _SystemConfigurationModuleBase with _$SystemConfigurationModule {}

abstract class _SystemConfigurationModuleBase with Store {
  @observable
  Brightness brightness = Brightness.light;
  @computed
  ThemeData get theme => brightness == Brightness.light
      ? getThemeData(lightTheme)
      : getThemeData(darkTheme);
  @action
  void toggleBrightness() {
    brightness =
        brightness == Brightness.light ? Brightness.dark : Brightness.light;
  }
}
