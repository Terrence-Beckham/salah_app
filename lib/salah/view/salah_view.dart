import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
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
  final _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<SalahCubit>().fetchSalah('giza');
          // context.read<SalahCubit>().determinePosition();
        },
        child: const Icon(Icons.add_outlined),
      ),
      appBar: AppBar(
        title: const Text('OurSalah'),
      ),
      body: BlocBuilder<SalahCubit, SalahState>(
        builder: (context, state) {
          switch (state.status) {
            case SalahStatus.initial:
              return Center(child: Text(state.status.toString()));
            case SalahStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case SalahStatus.success:
              return const SalahSuccessView();
            // return Card(
            //   child: ListTile(
            //     leading: const Text('Fajr'),
            //     trailing: Text(state.salah.fajr),
            //   ),
            // );
            case SalahStatus.failure:
              return const Center(
                child: Text('Something went wrong'),
              );
          }
        },
      ),
    );
  }
}

class SalahSuccessView extends StatelessWidget {
  const SalahSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalahCubit, SalahState>(
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              Expanded(
                child: ListTile(
                  title: const Text('Fajr'),
                  trailing: Text(state.salah.fajr),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('Dhuhr'),
                  trailing: Text(state.salah.dhuhr),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('Asr'),
                  trailing: Text(state.salah.asr),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('Maghrib'),
                  trailing: Text(state.salah.maghrib),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('Isha'),
                  trailing: Text(state.salah.isha),
                ),
              ),
            ],
          ),
        );
      },
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
