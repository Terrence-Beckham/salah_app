import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salah_app/konstants/konstants.dart';
import 'package:salah_app/salah/view/salah_view.dart';
import 'package:salah_app/settings/data/settings_repository.dart';
import 'package:salah_app/settings/settings_bloc.dart';
import 'package:salah_app/widgets/athan_segment_selector.dart';
import 'package:salah_app/widgets/reciter_menu.dart';

class SalahSettingsPage extends StatelessWidget {
  const SalahSettingsPage({
    required PrayerName salahName,
    required String prayerTime,
    super.key,
  })  : _salahName = salahName,
        _prayerTime = prayerTime;

  final PrayerName _salahName;
  final String _prayerTime;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsBloc(context.read<SettingsRepository>())
        ..add(SettingsInitial()),
      child: _SalahSettingsView(
        prayerName: _salahName,
        prayerTime: _prayerTime,
      ),
    );
  }
}

class _SalahSettingsView extends StatelessWidget {
  const _SalahSettingsView({
    required PrayerName prayerName,
    required String prayerTime,
    super.key,
  })  : _prayerName = prayerName,
        _prayerTime = prayerTime;

  final PrayerName _prayerName;
  final String _prayerTime;

  // String updatePrayerTimeOffset(SettingsState state, PrayerName prayerName){
  // switch(prayerName){
  //   case PrayerName.fajr:
  //    return 'FajrIncrement';
  //     // TODO: Handle this case.
  //   case PrayerName.sharooq:
  //     // TODO: Handle this case.
  //   case PrayerName.dhuhr:
  //     // TODO: Handle this case.
  //   case PrayerName.asr:
  //     // TODO: Handle this case.
  //   case PrayerName.maghrib:
  //     // TODO: Handle this case.
  //   case PrayerName.isha:
  //     // TODO: Handle this case.
  // }return 0;

  int calculateOffsetTime(PrayerName prayerName, SettingsState state) {
    switch (prayerName) {
      case PrayerName.fajr:
        return state.fajrOffset;

      case PrayerName.sharooq:
        break;
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        switch (state.status) {
          case SettingsStatus.initial:
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
                                _prayerName.name.capitalize(),
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
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 8, right: 16),
                                    child: Icon(
                                      Icons.location_on_outlined,
                                      size: 32,
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                  Text(
                                    'Bulaaq Dekroor',
                                    style: TextStyle(
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
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'original time',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color:
                                                      AppColor.desaturatedGreen,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 32,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Text(
                                                  _prayerTime,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: AppColor
                                                        .desaturatedGreen,
                                                  ),
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
                                                  onPressed: () => context
                                                      .read<SettingsBloc>()
                                                      .add(
                                                        OffsetDecrement(
                                                          prayerName:
                                                              _prayerName,
                                                        ),
                                                      ),
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
                                                  child: Text(
                                                    calculateOffsetTime(
                                                      _prayerName,
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
                                                          prayerName:
                                                              _prayerName,
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
                                          const Row(
                                            children: [
                                              Text(
                                                'adjusted time',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color:
                                                      AppColor.desaturatedGreen,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 32,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(16),
                                                child: Text(
                                                  '12:30 AM',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: AppColor
                                                        .desaturatedGreen,
                                                  ),
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
