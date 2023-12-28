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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<SalahCubit>().fetchSalah('giza');
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
    return const Center(
      child: Column(
        children: [
          Expanded(
            child: ListTile(
              title: Text('Fajr'),
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text('Dhuhr'),
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text('Asr'),
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text('Maghrib'),
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text('Isha'),
            ),
          ),
        ],
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
