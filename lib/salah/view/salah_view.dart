import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salah_app/Data/timer_repository.dart';
import 'package:salah_app/athan_player/views/athan_player_view.dart';
import 'package:salah_app/konstants/konstants.dart';
import 'package:salah_app/salah/salah_bloc.dart';
import 'package:salah_app/salah_settings/view/salah_settings_view.dart';
import 'package:salah_app/settings/view/settings_view.dart';
import 'package:salah_repository/salah_repository.dart';

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
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == SalahStatus.athanPlaying) {
            Navigator.push(
              context,
              MaterialPageRoute<AthanPlayer>(
                builder: (context) => AthanPlayer(
                  salahName: state.currentSalah!.name,
                  timerRepository: context.read<TimerRepository>(),
                ),
              ),
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
                case SalahStatus.athanPlaying:
                  ;
                case SalahStatus.failure:
                  return const Center(
                    child: Text('Check you internet connection and try again'),
                  );
              }
              return const Center();
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
                          state.currentSalah!.name,
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
                          '${state.hoursLeft} hrs & ${state.minutesLeft} '
                          'min until ${state.nextSalah!.name} ',
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
                          MaterialPageRoute<SalahSettingsView>(
                            builder: (context) => const SettingsPage(),
                          ),
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
                                salahName: state.currentSalah!.name,
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
                height: 2,
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
                height: 2,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            onTap: () => launchSalahSettingsView(context),
                            leading: IconButton(
                              icon: const Icon(
                                Icons.notifications_active_outlined,
                                color: AppColor.accentGreen,
                              ),
                              onPressed: () {},
                            ),
                            title: const Text(
                              'Fajr',
                              style: TextStyle(
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
                            // trailing: Text(state.salah.fajr),
                            trailing: Text(
                              state.salah.fajr,
                              style: const TextStyle(
                                color: AppColor.desaturatedGreen,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColor.accentGreen,
                      height: 2,
                    ),
                    Expanded(
                      child: ListTile(
                        onTap: () => launchSalahSettingsView(context),
                        leading: IconButton(
                          icon: const Icon(
                            Icons.notifications_active_outlined,
                            color: AppColor.accentGreen,
                          ),
                          onPressed: () {},
                        ),
                        title: const Text(
                          'Sharooq',
                          style: TextStyle(
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
                        trailing: Text(
                          state.salah.sharooq,
                          style: const TextStyle(
                            color: AppColor.desaturatedGreen,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColor.accentGreen,
                      height: 2,
                    ),
                    Expanded(
                      child: ListTile(
                        onTap: () => launchSalahSettingsView(context),
                        leading: IconButton(
                          icon: const Icon(
                            Icons.notifications_active_outlined,
                            color: AppColor.accentGreen,
                          ),
                          onPressed: () {},
                        ),
                        title: const Text(
                          'Dhuhr',
                          style: TextStyle(
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
                        trailing: Text(
                          state.salah.dhuhr,
                          style: const TextStyle(
                            color: AppColor.desaturatedGreen,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColor.accentGreen,
                      height: 2,
                    ),
                    Expanded(
                      child: ListTile(
                        onTap: () => launchSalahSettingsView(context),
                        leading: IconButton(
                          icon: const Icon(
                            Icons.notifications_active_outlined,
                            color: AppColor.accentGreen,
                          ),
                          onPressed: () {},
                        ),
                        title: const Text(
                          'Asr',
                          style: TextStyle(
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
                        trailing: Text(
                          state.salah.asr,
                          style: const TextStyle(
                            color: AppColor.desaturatedGreen,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColor.accentGreen,
                      height: 2,
                    ),
                    Expanded(
                      child: ListTile(
                        onTap: () => launchSalahSettingsView(context),
                        leading: IconButton(
                          icon: const Icon(
                            Icons.notifications_active_outlined,
                            color: AppColor.accentGreen,
                          ),
                          onPressed: () {},
                        ),
                        title: const Text(
                          'Maghrib',
                          style: TextStyle(
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
                        trailing: Text(
                          state.salah.maghrib,
                          style: const TextStyle(
                            color: AppColor.desaturatedGreen,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColor.accentGreen,
                      height: 2,
                    ),
                    Expanded(
                      child: ListTile(
                        onTap: () => launchSalahSettingsView(context),
                        leading: IconButton(
                          icon: const Icon(
                            Icons.notifications_active_outlined,
                            color: AppColor.accentGreen,
                          ),
                          onPressed: () {},
                        ),
                        title: const Text(
                          'Isha',
                          style: TextStyle(
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
                        trailing: Text(
                          state.salah.isha,
                          style: const TextStyle(
                            color: AppColor.desaturatedGreen,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColor.accentGreen,
                      height: 2,
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

  void launchSalahSettingsView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<SalahSettingsView>(
        builder: (context) => const SalahSettingsView(),
      ),
    );
  }
}

class PrayerTile extends StatelessWidget {
  const PrayerTile({
    required this.prayerName,
    super.key,
  });

  final String prayerName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 500,
      child: Card(
        color: const Color.fromARGB(255, 240, 238, 231),
        child: ListTile(
          leading: Text(prayerName),
        ),
      ),
    );
  }
}
