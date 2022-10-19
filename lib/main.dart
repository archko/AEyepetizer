import 'package:aeyepetizer/app.dart';
import 'package:flutter/material.dart';
import 'package:mmkv/mmkv.dart';

void main() async {
  // must wait for MMKV to finish initialization
  final rootDir = await MMKV.initialize();
  print('MMKV for flutter with rootDir = $rootDir');
  runApp(createApp());
}
