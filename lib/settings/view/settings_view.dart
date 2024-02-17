import 'package:flutter/material.dart';
import 'package:salah_app/konstants/konstants.dart';
import 'package:salah_app/widgets/athan_segment_selector.dart';
import 'package:salah_app/widgets/authority_picker_menu.dart';
import 'package:salah_app/widgets/language_picker_menu.dart';
import 'package:salah_app/widgets/reciter_menu.dart';

@override
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsView();
  }
}
@override
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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
                  height: 100,
                  child: ColoredBox(
                    color: AppColor.backgroundGreen,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Settings',
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
                      AppColor.mainDivider,
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 100,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Language',
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
                  padding: EdgeInsets.only(right: 8),
                  child: LanguagePickerMenu(),
                ),
              ],
            ),Row(
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
                          'School',
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
                  padding: EdgeInsets.only(right: 16),
                  child: AuthorityPickerMenu(),
                ),
              ],
            ),Row(
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
                          'Authority',
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
                  padding: EdgeInsets.only(right: 8),
                  child: AthanSoundMenu(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
