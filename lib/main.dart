import 'package:flutter/material.dart';
import 'package:gaana/bindings/globalBindings.dart';
import 'package:gaana/player.dart';
import 'package:gaana/screens/main_screen.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'screens/pages/home_screen.dart';

void main() async{
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gaana',
      theme: ThemeData.dark(),
      initialBinding: GlobalBindings(),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}
