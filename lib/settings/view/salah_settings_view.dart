import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salah_app/Data/repositories/settings_repository.dart';
import 'package:salah_app/Data/repositories/timer_repository.dart';
import 'package:salah_app/konstants/konstants.dart';
import 'package:salah_app/salah/models/salah.dart';
import 'package:salah_app/salah/view/salah_view.dart';
import 'package:salah_app/settings/settings_bloc.dart';
import 'package:salah_app/widgets/athan_segment_selector.dart';
import 'package:salah_app/widgets/reciter_menu.dart';

class SalahSettingsPage extends StatelessWidget {
  const SalahSettingsPage({
    required Salah salah,
    required PrayerName salahName,
    super.key,
  })  : _salahName = salahName,
        _salah = salah;

  final PrayerName _salahName;
  final Salah _salah;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsBloc(
        _salah,
        context.read<SettingsRepository>(),
        context.read<TimerRepository>(),
      )..add(SettingsInitial(salah: _salah)),
      child: _SalahSettingsView(
        salahName: _salahName,
        salah: _salah,
      ),
    );
  }
}

class _SalahSettingsView extends StatelessWidget {
  _SalahSettingsView({
    required Salah salah,
    required PrayerName salahName,
    super.key,
  })  : _salahName = salahName,
        _salah = salah {
    // displayOriginalAndOffsetTimes(_salahName);
  }

  final PrayerName _salahName;
  final Salah _salah;

  int calculateOffsetTime(PrayerName prayerName, SettingsState state) {
    switch (prayerName) {
      case PrayerName.fajr:
        return state.fajrOffset;
      case PrayerName.sharooq:
        return state.sharooqOffset;
      case PrayerName.dhuhr:
        return state.dhuhrOffset;
      case PrayerName.asr:
        return state.asrOffset;
      case PrayerName.maghrib:
        return state.maghribOffset;
      case PrayerName.isha:
        return state.ishaOffset;
    }
    return 0;
  }

  // String calculateOriginalTime(PrayerName prayerName, SettingsState state) {
  //   switch (prayerName) {
  //     case PrayerName.fajr:
  //       return state.fajrTime;
  //     case PrayerName.sharooq:
  //       return state.sharooqTime;
  //     case PrayerName.dhuhr:
  //       return state.sharooqTime;
  //     case PrayerName.asr:
  //       return state.asrTime;
  //     case PrayerName.maghrib:
  //       return state.maghribTime;
  //     case PrayerName.isha:
  //       return state.ishaTime;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        switch (state.status) {
          case SettingsStatus.initial:
            // context.read<SettingsBloc>().add();
            return const Center(
              child: CircularProgressIndicator(),
            );

          case SettingsStatus.success:
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColor.backgroundGreen,
                  iconTheme: const IconThemeData(color: Colors.white),
                ),
                body: Column(
                  children: [
                    Stack(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: ColoredBox(
                            color: AppColor.backgroundGreen,
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                _salahName.name.capitalize(),
                                style: const TextStyle(
                                  color: AppColor.darkGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 48,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 8, right: 16),
                                    child: Icon(
                                      Icons.location_on_outlined,
                                      size: 32,
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                  Text(
                                    _salah.city,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 10,
                                          // shadow blur
                                          color: AppColor.darkGreen,
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
                              SizedBox(
                                height: 215,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 32, left: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Offset',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.darkGreen,
                                          shadows: [AppColor.mainShadow],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                  right: 8,
                                                ),
                                                child: Text(
                                                  'Original time',
                                                  style: TextStyle(
                                                    color: AppColor.accentGreen,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                switch (_salahName) {
                                                  PrayerName.fajr =>
                                                    state.salah.fajrTime,
                                                  PrayerName.sharooq =>
                                                    state.salah.sharooqTime,
                                                  PrayerName.dhuhr =>
                                                    state.salah.dhuhrTime,
                                                  PrayerName.asr =>
                                                    state.salah.asrTime,
                                                  PrayerName.maghrib =>
                                                    state.salah.maghribTime,
                                                  PrayerName.isha =>
                                                    state.salah.ishaTime,
                                                },
                                                style: const TextStyle(
                                                  color: AppColor.accentGreen,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: AppColor.accentGreen,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<SettingsBloc>()
                                                        .add(
                                                          OffsetDecrement(
                                                            salah: _salah,
                                                            prayerName:
                                                                _salahName,
                                                          ),
                                                        );


                                                  },
                                                  icon: const Icon(
                                                    Icons.remove_outlined,
                                                    color: Colors.red,
                                                    size: 48,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 68,
                                                width: 68,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: AppColor.accentGreen,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Center(
                                                  //Display Offset Time Field
                                                  child: Text(
                                                    calculateOffsetTime(
                                                      _salahName,
                                                      state,
                                                    ).toString(),
                                                    style: const TextStyle(
                                                      fontSize: 32,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: AppColor.accentGreen,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: IconButton(
                                                  onPressed: () => context
                                                      .read<SettingsBloc>()
                                                      .add(
                                                        OffsetIncrement(
                                                          salah: _salah,
                                                          prayerName:
                                                              _salahName,
                                                        ),
                                                      ),
                                                  icon: const Icon(
                                                    Icons.add_outlined,
                                                    color: Colors.greenAccent,
                                                    size: 48,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                  right: 8,
                                                ),
                                                child: Text(
                                                  'Adjusted time',
                                                  style: TextStyle(
                                                    color: AppColor.accentGreen,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                switch (_salahName) {
                                                PrayerName.fajr =>
                                                state.salah.fajrOffsetTime,
                                                PrayerName.sharooq =>
                                                state.salah.sharooqOffsetTime,
                                                PrayerName.dhuhr =>
                                                state.salah.dhuhrOffsetTime,
                                                PrayerName.asr =>
                                                state.salah.asrOffsetTime,
                                                PrayerName.maghrib =>
                                                state.salah.maghribOffsetTime,
                                                PrayerName.isha =>
                                                state.salah.ishaOffsetTime,
                                              },
                                                style: const TextStyle(
                                                  color: AppColor.accentGreen,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AppColor.mainDivider,
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Athan',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.darkGreen,
                                              shadows: [AppColor.mainShadow],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: AthanSegmentButton(),
                                  ),
                                ],
                              ),
                              AppColor.mainDivider,
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Reciter',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.darkGreen,
                                              shadows: [AppColor.mainShadow],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(child: AthanSoundMenu()),
                                ],
                              ),
                              AppColor.mainDivider,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          case SettingsStatus.loading:
          // TODO: Handle this case.
          case SettingsStatus.failure:
          // TODO: Handle this case.
        }
        return const Center(
          child: Text('Something went very wrong'),
        );
      },
    );
  }
}
