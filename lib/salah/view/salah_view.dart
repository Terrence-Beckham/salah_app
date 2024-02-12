import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salah_app/salah/cubit/salah_cubit.dart';
import 'package:salah_repository/salah_repository.dart';

class SalahPage extends StatelessWidget {
  const SalahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          // SalahCubit(RepositoryProvider.of<SalahRepository>(context)),
          SalahCubit(context.read<SalahRepository>()),
      child: const SalahView(),
    );
  }
}

class SalahView extends StatelessWidget {
  const SalahView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<SalahCubit>().fetchSalah('Giza');
          // BlocProvider.of<SalahCubit>(context).fetchSalah('Makkah');
          //The above is equivalent to this
          // final bloc = context.read<SalahCubit>();
          //  bloc.fetchSalah('Makkah');

          // context.read<SalahCubit>().fetchSalah('giza');
          // context.read<SalahCubit>().determinePosition();
        },
        child: const Icon(Icons.add_outlined),
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
                child: Text('Check you internet connection and try again'),
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
    // final state = context.watch<SalahCubit>().state;
    return BlocBuilder<SalahCubit, SalahState>(
      builder: (context, state) {
        return SafeArea(
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Image.asset('assets/images/main_background.png'),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 48,
                          width: 100,
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 16,
                              top: 16,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC8F4E8),
                              border: Border.all(),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                state.salah.fajr,
                                style:  const TextStyle(
                                  color: Color(0xFF17794F),
                                  fontSize: 32,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Fajr'),
                    // trailing: Text(state.salah.fajr),
                    trailing: Text(state.salah.fajr),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Sharooq'),
                    trailing: Text(state.salah.dhuhr),
                    // trailing: Text(context.watch<SalahCubit>().state.salah.dhuhr),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Dhuhr'),
                    trailing: Text(state.salah.dhuhr),
                    // trailing: Text(context.watch<SalahCubit>().state.salah.dhuhr),
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
