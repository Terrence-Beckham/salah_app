import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:salah_app/salah/view/salah_view.dart';
import 'package:salah_repository/salah_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp(
      {required SalahRepository salahRepository, super.key})
      : _salahRepository = salahRepository;

  final SalahRepository _salahRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _salahRepository,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SalahPage(),
      ),
    );
  }
}

// class SalahAppView extends StatelessWidget {
//   const SalahAppView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primaryColor: Colors.deepPurple),
//       home: const SalahView(),
//     );
//   }
// }
