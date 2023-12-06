import 'package:flutter/material.dart';

class SalahView extends StatelessWidget {
  const SalahView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              child: Container(
                height: 200,
                width: 500,
                color: Colors.deepPurple,
              ),
            ),
            const Expanded(
              child: PrayerTile(
                prayerName: Text('Fajr'),
              ),
            ),
            const Expanded(
              child: PrayerTile(
                prayerName: Text('Dhuhr'),
              ),
            ),
            const Expanded(
              child: PrayerTile(
                prayerName: Text('Asr'),
              ),
            ),
            const Expanded(
              child: PrayerTile(
                prayerName: Text('Maghrib'),
              ),
            ),
            const Expanded(
              child: PrayerTile(
                prayerName: Text('Isha'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrayerTile extends StatelessWidget {
  const PrayerTile({
    required this.prayerName,
    super.key,
  });
  final Text prayerName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 500,
      child: Card(
        color: const Color.fromARGB(255, 240, 238, 231),
        child: prayerName,
      ),
    );
  }
}
