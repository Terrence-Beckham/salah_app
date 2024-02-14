import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salah_app/konstants/konstants.dart';
import 'package:salah_app/salah/cubit/salah_cubit.dart';
import 'package:salah_app/salah_settings/view/salah_settings_view.dart';
import 'package:salah_repository/salah_repository.dart';

class SalahPage extends StatelessWidget {
  const SalahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          // SalahCubit(RepositoryProvider.of<SalahRepository>(context)),
          SalahCubit(context.read<SalahRepository>()),
      child: const SalahView(),
    );
  }
}

class SalahView extends StatelessWidget {
  const SalahView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<SalahCubit>().fetchSalah('Giza');
          // BlocProvider.of<SalahCubit>(context).fetchSalah('Makkah');
          //The above is equivalent to this
          // final bloc = context.read<SalahCubit>();
          //  bloc.fetchSalah('Makkah');

          // context.read<SalahCubit>().fetchSalah('giza');
          // context.read<SalahCubit>().determinePosition();
        },
        child: const Icon(Icons.add_outlined),
      ),
      body: BlocBuilder<SalahCubit, SalahState>(
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
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Image.asset('assets/images/main_background.png'),
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
                        child: const Center(
                          child: Text(
                            ' Maghrib',
                            style: TextStyle(
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
                        width: 200,
                        decoration: BoxDecoration(
                          color: AppColor.lightAccentGreen,
                          border: Border.all(color: AppColor.accentGreen),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: const Text(
                          '1 hr and 8 mins until Isha ',
                          style: TextStyle(
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
                    Positioned(
                      top: 16,
                      right: 16,
                      child: IconButton(
                        onPressed: () {},
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.location_on_outlined,
                            color: AppColor.darkGreen,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 53,
                      ),
                      const Text(
                        ' Bulaaq Dekroor',
                        style: TextStyle(
                          color: AppColor.desaturatedGreen,
                          fontSize: 24,
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
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '20 Rajab, 1444',
                            style: TextStyle(
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
                          Text(
                            '20 November, 2024',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.desaturatedGreen,
                              fontWeight: FontWeight.bold,
                            ),
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
                              fontWeight: FontWeight.bold,
                              color: AppColor.darkGreen,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  // shadow blur
                                  color: AppColor.desaturatedGreen,
                                  // shadow color
                                  offset: Offset(
                                      2, 4,), // how much shadow will be shown
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
                            'Dhuhr',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.darkGreen,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  // shadow blur
                                  color: AppColor.desaturatedGreen,
                                  // shadow color
                                  offset: Offset(
                                      2, 4), // how much shadow will be shown
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
                              fontWeight: FontWeight.bold,
                              color: AppColor.darkGreen,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  // shadow blur
                                  color: AppColor.desaturatedGreen,
                                  // shadow color
                                  offset: Offset(
                                      2, 4), // how much shadow will be shown
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
                              fontWeight: FontWeight.bold,
                              color: AppColor.darkGreen,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  // shadow blur
                                  color: AppColor.desaturatedGreen,
                                  // shadow color
                                  offset: Offset(
                                      2, 4), // how much shadow will be shown
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
                              fontWeight: FontWeight.bold,
                              color: AppColor.darkGreen,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  // shadow blur
                                  color: AppColor.desaturatedGreen,
                                  // shadow color
                                  offset: Offset(
                                      2, 4), // how much shadow will be shown
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
