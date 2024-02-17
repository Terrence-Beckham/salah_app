import 'package:flutter/material.dart';
import 'package:salah_app/konstants/konstants.dart';

enum Languages { english, arabic, systemDefault }

@override
class LanguagePickerMenu extends StatefulWidget {
  const LanguagePickerMenu({super.key});

  @override
  State<LanguagePickerMenu> createState() => _LanguagePickerMenuState();
}

class _LanguagePickerMenuState extends State<LanguagePickerMenu> {
  List<String> items = [
    Languages.english.name,
    Languages.systemDefault.name,
    Languages.arabic.name,
  ];
  String selectedItem = Languages.english.name;

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
                    fontSize: 24,
                    color: AppColor.desaturatedGreen,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (item) => setState(() {
          selectedItem = item!;
        }),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:salah_app/konstants/konstants.dart';
//
// @override
// class AthanSoundMenu extends StatefulWidget {
//   const AthanSoundMenu({super.key});
//
//   @override
//   State<AthanSoundMenu> createState() => _AthanSoundMenuState();
// }
//
// class _AthanSoundMenuState extends State<AthanSoundMenu> {
//   List<String> items = [
//     'Fares Abdul Ghani',
//     'Abdel Moneim',
//     'Abdulah Al Maknawe ',
//     'Hamza Al Majale'
//   ];
//   String? selectedItem = 'Fares Abdul Ghani';
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: DropdownButton<String>(
//         value: selectedItem,
//         items: items
//             .map(
//               (item) => DropdownMenuItem<String>(
//             value: item,
//             child: Text(
//               item,
//               style: const TextStyle(
//                 fontSize: 18,
//                 color: AppColor.desaturatedGreen,
//               ),
//             ),
//           ),
//         )
//             .toList(),
//         onChanged: (item) => setState(() {
//           selectedItem = item;
//         }),
//       ),
//     );
//   }
// }
