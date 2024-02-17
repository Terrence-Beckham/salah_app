import 'package:flutter/material.dart';
import 'package:salah_app/konstants/konstants.dart';

@override
class AthanSoundMenu extends StatefulWidget {
  const AthanSoundMenu({super.key});

  @override
  State<AthanSoundMenu> createState() => _AthanSoundMenuState();
}

class _AthanSoundMenuState extends State<AthanSoundMenu> {
  List<String> items = [
    'Fares Abdul Ghani',
    'Abdel Moneim',
    'Abdulah Al Maknawe ',
    'Hamza Al Majale'
  ];
  String? selectedItem = 'Fares Abdul Ghani';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        value: selectedItem,
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColor.desaturatedGreen,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (item) => setState(() {
          selectedItem = item;
        }),
      ),
    );
  }
}
