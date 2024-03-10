import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:salah_app/Data/timer_repository.dart';
import 'package:salah_app/konstants/konstants.dart';

class AthanPlayer extends StatefulWidget {
  const AthanPlayer(
      {required this.salahName, required this.timerRepository, super.key});

  final String salahName;
  final TimerRepository timerRepository;

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
    await audioPlayer
        .play(AssetSource('athans/Abdel_Moneim_Abdel_Mobdi_Adhan.mp3'));
  }

  @override
  Widget build(BuildContext context) {
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
                  ' $widget.salahName',
                  style:
                      const TextStyle(color: AppColor.darkGreen, fontSize: 24),
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
  }
}
