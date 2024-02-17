import 'package:flutter/material.dart';
import 'package:salah_app/konstants/konstants.dart';

@override
class AthanPlayer extends StatelessWidget {
  const AthanPlayer({super.key});

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
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const CircleAvatar(
              backgroundColor: AppColor.darkGreen,
              maxRadius: 120,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 100,
                child: Text(
                  'Prayer Name',
                  style: TextStyle(color: AppColor.darkGreen, fontSize: 24),
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
              height: 100,
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
                        size: 48,
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
                        size: 48,
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
