import 'package:flutter/material.dart';
import 'package:gaana/bindings/globalBindings.dart';
import 'package:gaana/screens/main_screen.dart';
import 'package:gaana/screens/pages/sub_views/downloads_view.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';

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
