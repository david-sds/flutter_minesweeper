import 'package:flutter_minesweeper/modules/system_configuration_module.dart';
import 'package:provider/provider.dart';

final providers = [
  Provider<SystemConfigurationModule>(create: (_) => SystemConfigurationModule(),),
];
