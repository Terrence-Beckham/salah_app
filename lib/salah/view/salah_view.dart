import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salah_app/salah/cubit/salah_cubit.dart';
import 'package:salah_repository/salah_repository.dart';

class SalahPage extends StatelessWidget {
  const SalahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SalahCubit(context.read<SalahRepository>()),
      child: const SalahView(),
    );
  }
}

class SalahView extends StatefulWidget {
  const SalahView({super.key});

  @override
  State<SalahView> createState() => _SalahViewState();
}

class _SalahViewState extends State<SalahView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OurSalah'),
      ),
      body: BlocConsumer<SalahCubit, SalahState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListTile(
                  title: const Text('Fajr'),
                  leading: Text(state.salah.fajr),
                ),
              ),
              const Expanded(
                child: ListTile(
                  title: Text('Dhuhr'),
                ),
              ),
              const Expanded(
                child: ListTile(
                  title: Text('Asr'),
                ),
              ),
              const Expanded(
                child: ListTile(
                  title: Text('Maghrib'),
                ),
              ),
              const Expanded(
                child: ListTile(
                  title: Text('Isha'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PrayerTile extends StatelessWidget {
  const PrayerTile({
    required this.prayerName,
    super.key,
  });

  final String prayerName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 500,
      child: Card(
        color: const Color.fromARGB(255, 240, 238, 231),
        child: ListTile(
          leading: Text(prayerName),
        ),
      ),
    );
  }
}
