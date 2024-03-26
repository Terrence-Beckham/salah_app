import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salah_app/Data/repositories/settings_repository.dart';
import 'package:salah_app/Data/repositories/timer_repository.dart';
import 'package:salah_app/athan_player/views/athan_player_view.dart';
import 'package:salah_app/konstants/konstants.dart';
import 'package:salah_app/salah/models/salah.dart';
import 'package:salah_app/salah/salah_bloc.dart';
import 'package:salah_app/settings/settings_bloc.dart';
import 'package:salah_app/settings/view/salah_settings_view.dart';
import 'package:salah_app/settings/view/settings_view.dart';
import 'package:salah_repository/salah_repository.dart';

enum PrayerName { fajr, sharooq, dhuhr, asr, maghrib, isha }

class SalahPage extends StatelessWidget {
  const SalahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          // SalahCubit(RepositoryProvider.of<SalahRepository>(context)),
          SalahBloc(
        context.read<SalahRepository>(),
        context.read<TimerRepository>(),
        context.read<SettingsRepository>(),
      )..add(const SalahInitial()),
      child: const SalahView(),
    );
  }
}

class SalahView extends StatelessWidget {
  const SalahView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SalahBloc, SalahState>(
        listenWhen: (previous, current) =>
            previous.salah.isAthanTime != current.salah.isAthanTime,
        listener: (context, state) {
          if (state.salah.isAthanTime) {
            Navigator.push(
              context,
              MaterialPageRoute<AthanPlayer>(
                builder: (context) => AthanPlayer(
                  salahName: state.salah.nextSalah.name,
                  timerRepository: context.read<TimerRepository>(),
                ),
              ),
            ).then(
              (value) => context.read<SalahBloc>().add(const SalahInitial()),
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<SalahBloc, SalahState>(
            builder: (context, state) {
              switch (state.status) {
                case SalahStatus.initial:
                  return Center(child: Text(state.status.toString()));
                case SalahStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case SalahStatus.success:
                  return const SalahSuccessView();
                case SalahStatus.failure:
                  return const Center(
                    child: Text('Check you internet connection and try again'),
                  );
              }
            },
          );
        },
      ),
    );
  }
}

class SalahSuccessView extends StatelessWidget {
  const SalahSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    // final state = context.watch<SalahCubit>().state;
    return BlocBuilder<SalahBloc, SalahState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    'assets/images/main_background.png',
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      height: 48,
                      width: 150,
                      decoration: BoxDecoration(
                        color: AppColor.lightAccentGreen,
                        border: Border.all(color: AppColor.accentGreen),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          state.salah.currentSalah.name,
                          style: const TextStyle(
                            color: Color(0xFF17794F),
                            fontSize: 32,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                // shadow blur
                                color: AppColor.desaturatedGreen,
                                // shadow color
                                offset: Offset(
                                  2,
                                  4,
                                ), // how much shadow will be shown
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 75,
                    left: 16,
                    child: Container(
                      height: 24,
                      width: 225,
                      decoration: BoxDecoration(
                        color: AppColor.lightAccentGreen,
                        border: Border.all(color: AppColor.accentGreen),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${state.salah.hoursLeft} hrs &'
                          ' ${state.salah.minutesLeft} '
                          'min until ${state.salah.nextSalah.name} ',
                          style: const TextStyle(
                            color: Color(0xFF17794F),
                            fontSize: 16,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                // shadow blur
                                color: AppColor.desaturatedGreen,
                                // shadow color
                                offset: Offset(
                                  2,
                                  4,
                                ), // how much shadow will be shown
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<SalahSettingsPage>(
                            builder: (context) => const SettingsPage(),
                          ),
                        ).then(
                          (value) => context
                              .read<SalahBloc>()
                              .add(const SalahInitial()),
                        );
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              ColoredBox(
                color: AppColor.lightAccentGreen,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: IconButton(
                        onPressed: () {
                          // context.read<SalahCubit>().launchAthanPlayer();
                          // showDialog<SimpleDialog>(
                          //   context: context,
                          //   builder: (context) => const AthanPlayer(),
                          // );
                          // context.read<SalahCubit>().fetchSalah();
                          Navigator.push(
                            context,
                            MaterialPageRoute<AthanPlayer>(
                              builder: (context) => AthanPlayer(
                                timerRepository:
                                    context.read<TimerRepository>(),
                                salahName: state.salah.currentSalah.name,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.location_on_outlined,
                          color: AppColor.darkGreen,
                        ),
                      ),
                    ),
                    Text(
                      state.salah.city,
                      style: const TextStyle(
                        color: AppColor.desaturatedGreen,
                        fontSize: 24,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () {
                          // context.read<SalahCubit>().init();
                        },
                        icon: const Icon(
                          Icons.update_outlined,
                          color: AppColor.darkGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: AppColor.accentGreen,
                height: 4,
                thickness: 2,
              ),
              SizedBox(
                height: 75,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: IconButton(
                        color: Colors.orangeAccent,
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {},
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          // '20 Rajab, 1444',
                          '${state.salah.hijriDay}'
                          ' ${state.salah.hijriMonthEnglish} '
                          '${state.salah.hijriYear}',
                          style: const TextStyle(
                            fontSize: 24,
                            color: AppColor.darkGreen,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                // shadow blur
                                color: AppColor.desaturatedGreen,
                                // shadow color
                                offset: Offset(
                                  2,
                                  4,
                                ), // how much shadow will be shown
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                // '20 November, 2024',
                                ' ${state.salah.gregorianWeekdayEnglish} ,',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColor.desaturatedGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              // '20 November, 2024',
                              state.salah.readableDate,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColor.desaturatedGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      color: Colors.orangeAccent,
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const Divider(
                color: AppColor.accentGreen,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: PrayerTile(
                        timerRepository: context.read<TimerRepository>(),
                        salah: state.salah,
                        prayerName: PrayerName.fajr,
                        prayerTime: state.salah.fajrOffsetTime,
                        prayerOffsetTime: state.salah.fajrOffsetTime,
                      ),
                    ),
                    const Divider(
                      color: AppColor.accentGreen,
                    ),
                    Expanded(
                      child: PrayerTile(
                        timerRepository: context.read<TimerRepository>(),
                        salah: state.salah,
                        prayerName: PrayerName.sharooq,
                        prayerTime: state.salah.sharooqTime,
                        prayerOffsetTime: state.salah.sharooqOffsetTime,
                      ),
                    ),
                    const Divider(
                      color: AppColor.accentGreen,
                    ),
                    Expanded(
                      child: PrayerTile(
                        timerRepository: context.read<TimerRepository>(),
                        salah: state.salah,
                        prayerName: PrayerName.dhuhr,
                        prayerTime: state.salah.dhuhrTime,
                        prayerOffsetTime: state.salah.dhuhrOffsetTime,
                      ),
                    ),
                    const Divider(
                      color: AppColor.accentGreen,
                    ),
                    Expanded(
                      child: PrayerTile(
                        timerRepository: context.read<TimerRepository>(),
                        salah: state.salah,
                        prayerName: PrayerName.asr,
                        prayerTime: state.salah.asrTime,
                        prayerOffsetTime: state.salah.asrOffsetTime,
                      ),
                    ),
                    const Divider(
                      color: AppColor.accentGreen,
                    ),
                    Expanded(
                      child: PrayerTile(
                        timerRepository: context.read<TimerRepository>(),
                        salah: state.salah,
                        prayerName: PrayerName.maghrib,
                        prayerTime: state.salah.maghribTime,
                        prayerOffsetTime: state.salah.maghribOffsetTime,
                      ),
                    ),
                    const Divider(
                      color: AppColor.accentGreen,
                    ),
                    Expanded(
                      child: PrayerTile(
                        timerRepository: context.read<TimerRepository>(),
                        salah: state.salah,
                        prayerName: PrayerName.isha,
                        prayerTime: state.salah.ishaTime,
                        prayerOffsetTime: state.salah.ishaOffsetTime,
                      ),
                    ),
                    const Divider(
                      color: AppColor.accentGreen,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PrayerTile extends StatelessWidget {
  const PrayerTile({
    required PrayerName prayerName,
    required String prayerTime,
    required String prayerOffsetTime,
    required Salah salah,
    required TimerRepository timerRepository,
    super.key,
  })  : _prayerTime = prayerTime,
        _prayerName = prayerName,
        _prayerOffsetTime = prayerOffsetTime,
        _salah = salah,
        _timerRepository = timerRepository;

  final PrayerName _prayerName;
  final String _prayerTime;
  final String _prayerOffsetTime;
  final Salah _salah;
  final TimerRepository _timerRepository;

  void launchSalahSettingsView(BuildContext context) {
    _timerRepository.cancelTimer();
    Navigator.of(context)
        .push(
          MaterialPageRoute<SalahSettingsPage>(
            builder: (context) => BlocProvider<SettingsBloc>(
              create: (context) => SettingsBloc(
                _salah,
                context.read<SettingsRepository>(),
                context.read<TimerRepository>(),
              ),
              child: SalahSettingsPage(
                salah: _salah,
                salahName: _prayerName,
              ),
            ),
          ),
        )
        .then(
          (salah) => context.read<SalahBloc>().add(const RequestSalah()),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 16),
                child: IconButton(
                  color: AppColor.accentGreen,
                  onPressed: () => {},
                  icon: const Icon(Icons.notifications_active_outlined),
                ),
              ),
              Text(
                _prayerName.name.capitalize(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColor.darkGreen,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      // shadow blur
                      color: AppColor.desaturatedGreen,
                      // shadow color
                      offset: Offset(
                        2,
                        4,
                      ), // how much shadow will be shown
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                _prayerOffsetTime,
                style: const TextStyle(
                  color: AppColor.desaturatedGreen,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: IconButton(
                  onPressed: () => launchSalahSettingsView(context),
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: AppColor.accentGreen,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
