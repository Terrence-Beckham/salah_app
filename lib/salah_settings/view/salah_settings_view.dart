import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salah_app/konstants/konstants.dart';

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
        body: const Column(
          children: [
            Stack(
              children: [
                SizedBox(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8,right: 16),
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
