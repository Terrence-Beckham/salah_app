import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:ui';

final dio = Dio();

void getHttp() async {
  final response = await dio.get(
      'http://api.aladhan.com/v1/calendar/2017/4?latitude=51.508515&longitude=-0.1254872&method=2 http://api.aladhan.com/v1/calendar/2019?latitude=51.508515&longitude=-0.1254872&method=2');
  print(response);
}
