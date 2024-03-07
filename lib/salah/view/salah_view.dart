import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salah_app/Data/timer_repository.dart';
import 'package:salah_app/konstants/konstants.dart';
import 'package:salah_app/salah/cubit/salah_cubit.dart';
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
          SalahCubit(
        context.read<SalahRepository>(),
        context.read<TimerRepository>(),
      ),
      child: const SalahView(),
    );
  }
}

class SalahView extends StatelessWidget {
  const SalahView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SalahCubit, SalahState>(
        builder: (context, state) {
          switch (state.status) {
            case SalahStatus.initial:
              context.read<SalahCubit>().init();
              context.read<SalahCubit>().listenToTimeLineStream();

              return Center(child: Text(state.status.toString()));
            case SalahStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case SalahStatus.success:
              return const SalahSuccessView();
            case SalahStatus.athanPlaying:
              return  const AthanPlayer();
            case SalahStatus.failure:
              return const Center(
                child: Text('Check you internet connection and try again'),
              );
          }
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
    return BlocBuilder<SalahCubit, SalahState>(
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
                          state.currentSalah.name,
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
                          'min until ${state.nextSalah.name} ',
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
                          context.read<SalahCubit>().launchAthanPlayer();
                          // showDialog<SimpleDialog>(
                          //   context: context,
                          //   builder: (context) => const AthanPlayer(),
                          // );
                          // context.read<SalahCubit>().fetchSalah();
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
                          context.read<SalahCubit>().init();
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

class AthanPlayer extends StatefulWidget {
  const AthanPlayer({super.key});

  @override
  State<AthanPlayer> createState() => _AthanPlayerState();
}

class _AthanPlayerState extends State<AthanPlayer> {
  final audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
   playAthan();
  }

  Future<void> playAthan() async {
    await audioPlayer.play(AssetSource('athans/Abdel_Moneim_Abdel_Mobdi_Adhan.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalahCubit, SalahState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColor.accentGreen,
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Ink(
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(
                            side: BorderSide(
                              color: Colors.white,
                              width: 8,
                            ),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Navigator.of(context).pop();
                            //
                            context.read<SalahCubit>().init();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                 CircleAvatar(
                  backgroundColor: AppColor.darkGreen,
                  maxRadius: 120,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    maxRadius: 100,
                    child: Text(
                      ' ${state.currentSalah.name}',
                      style: const TextStyle(color: AppColor.darkGreen, fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Time since start of prayer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    ' 10:00',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Ink(
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(
                            side: BorderSide(
                              color: Colors.white,
                              width: 8,
                            ),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_off_outlined,
                            color: Colors.red,
                            size: 24,
                          ),
                        ),
                      ),
                      Ink(
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(
                            side: BorderSide(
                              color: Colors.white,
                              width: 8,
                            ),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.vibration_outlined,
                            color: Colors.yellow,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
