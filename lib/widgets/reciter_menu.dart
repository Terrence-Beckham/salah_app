import 'package:flutter/material.dart';
import 'package:salah_app/konstants/konstants.dart';

@override
class ReciterMenu extends StatefulWidget {
  const ReciterMenu({super.key});

  @override
  State<ReciterMenu> createState() => _ReciterMenuState();
}

class _ReciterMenuState extends State<ReciterMenu> {
  List<String> items = ['Maher Muaqally', 'Sudais', 'Shuraim', 'Huthafy'];
  String? selectedItem = 'Sudais';

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
                  style:
                      const TextStyle(fontSize: 24, color: AppColor.desaturatedGreen),
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
