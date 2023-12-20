import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'salah_state.dart';

class SalahCubit extends Cubit<SalahState> {
  SalahCubit() : super(SalahInitial());
}
