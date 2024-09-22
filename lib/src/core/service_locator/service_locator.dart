import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:school_app/src/core/service_locator/service_locator.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
void configurationDependencies() => getIt.init();
