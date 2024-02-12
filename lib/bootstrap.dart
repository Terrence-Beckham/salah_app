import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class AppBlocObserver extends BlocObserver {
    AppBlocObserver():_logger = Logger() ;

  final  Logger _logger ;
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {

    super.onChange(bloc, change);
    _logger.i('onChange(${bloc.runtimeType}, $change)');
    log('onChange(${bloc.runtimeType}, $change)');

  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    _logger.i('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer =  AppBlocObserver();


  // Add cross-flavor configuration here
  WidgetsFlutterBinding.ensureInitialized();
log('Widgets have been initialized in the Bootstrap file');
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  runApp(await builder());
}
