import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salah_app/Data/timer_repository.dart';
import 'package:salah_app/salah/view/salah_view.dart';
import 'package:salah_app/settings/data/settings_repository.dart';
import 'package:salah_repository/salah_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    required SalahRepository salahRepository,
    required TimerRepository timerRepository,
    required SettingsRepository settingsRepository,
    super.key,
  })  : _salahRepository = salahRepository,
        _settingsRepository = settingsRepository,
        _timerRepository = timerRepository;

  final SalahRepository _salahRepository;
  final TimerRepository _timerRepository;
  final SettingsRepository _settingsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _timerRepository),
        RepositoryProvider.value(value: _salahRepository),
        RepositoryProvider.value(value: _settingsRepository),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SalahPage(),
      ),
    );
  }
}
