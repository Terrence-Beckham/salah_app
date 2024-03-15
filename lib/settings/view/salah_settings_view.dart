import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salah_app/konstants/konstants.dart';
import 'package:salah_app/widgets/athan_segment_selector.dart';
import 'package:salah_app/widgets/reciter_menu.dart';

class SalahSettingsView extends StatelessWidget {
  const SalahSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SalahSettingsPage();
  }
}

class SalahSettingsPage extends StatelessWidget {
  const SalahSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                      const Text(
                        'Maghrib',
                        style: TextStyle(
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
                            padding: EdgeInsets.only(left: 8, right: 16),
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
                          padding: const EdgeInsets.only(top: 32, left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  const Row(
                                    children: [
                                      Text(
                                        'original time',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.desaturatedGreen,
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
                                            color: AppColor.desaturatedGreen,
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
                                          onPressed: () {},
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
                                        child: const Center(
                                          child: Text(
                                            '00',
                                            style: TextStyle(
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
                                          onPressed: () {},
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
                                          color: AppColor.desaturatedGreen,
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
                                            color: AppColor.desaturatedGreen,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 100,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 100,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
  }
}
