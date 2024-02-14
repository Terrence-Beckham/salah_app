import 'package:flutter/material.dart';
import 'package:salah_app/konstants/konstants.dart';

enum AthanSoundSetting { sound, vibrate, silent }

class AthanSegmentButton extends StatefulWidget {
  const AthanSegmentButton({super.key});

  @override
  State<AthanSegmentButton> createState() => _AthanSegmentButtonState();
}

class _AthanSegmentButtonState extends State<AthanSegmentButton> {
  AthanSoundSetting athanView = AthanSoundSetting.sound;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<AthanSoundSetting>(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              // return Theme.of(context).colorScheme.primary.withOpacity(0.5);
              return AppColor.accentGreen.withOpacity(0.5);
            }
            return null; // Use the component's default.
          },
        ),

      ),
      segments: const <ButtonSegment<AthanSoundSetting>>[

        ButtonSegment<AthanSoundSetting>(
          value: AthanSoundSetting.sound,
          icon: Icon(Icons.notifications_active_outlined,color: Colors.greenAccent,),
        ),
        ButtonSegment<AthanSoundSetting>(
          value: AthanSoundSetting.silent,
          // label: Text('off'),
          icon: Icon(Icons.notifications_off_outlined,color: Colors.red,),
        ),
        ButtonSegment<AthanSoundSetting>(
          value: AthanSoundSetting.vibrate,
          // label: Text('Vibrate'),
          icon: Icon(Icons.vibration_outlined, color: Colors.orange,),
        ),
      ],
      selected: <AthanSoundSetting>{athanView},
      onSelectionChanged: (Set<AthanSoundSetting> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          athanView = newSelection.first;
        });
      },
    );
  }
}
