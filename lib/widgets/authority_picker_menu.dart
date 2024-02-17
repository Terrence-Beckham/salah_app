import 'package:flutter/material.dart';
import 'package:salah_app/konstants/konstants.dart';

@override
class AuthorityPickerMenu extends StatefulWidget {
  const AuthorityPickerMenu({super.key});

  @override
  State<AuthorityPickerMenu> createState() => _AuthorityPickerMenu();
}

class _AuthorityPickerMenu extends State<AuthorityPickerMenu> {
  List<String> items = [
    'Default',
    'University of Islamic Sciences Karachi',
    'Islamic Society of North America',
    ' Muslim World League',
    ' Umm Al-Qura University Makkah',
    ' Egyptian General Authority of Survey',
    'Institute of Geophysics University of Tehran',
    'Gulf Region',
    'Kuwait',
    'Qatar',
    'Majlis Ugama Islam Singapura Singapore',
    'Union Organization islamic de France',
    'Diyanet İşleri Başkanlığı Turkey',
    'Spiritual Administration of Muslims of Russia'
  ];
  String selectedItem = 'Default';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedItem,
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: SizedBox(width: 225,
                child: Text(

                  maxLines: 1,
                  softWrap: false,
                  item,
                  style: const TextStyle(

                    overflow: TextOverflow.ellipsis,
                    fontSize: 16,
                    color: AppColor.desaturatedGreen,
                  ),
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (item) => setState(() {
        selectedItem = item!;
      }),
    );
  }
}
//SizedBox(
//           width: 120.0,
//           child: Text(
//             "Enter Long Text",
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             softWrap: false,
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
//           ),
//         ),Text(

