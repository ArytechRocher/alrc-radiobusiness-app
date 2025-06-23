import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'audio_player_handler.dart';
import 'ui/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final audioHandler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.example.alrc_radio.channel.audio',
      androidNotificationChannelName: 'ALRC Radio Audio',
      androidNotificationOngoing: true,
    ),
  );

  runApp(MyApp(audioHandler: audioHandler));
}

class MyApp extends StatelessWidget {
  final AudioHandler audioHandler;
  const MyApp({required this.audioHandler, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALRC Radio Business',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomeScreen(audioHandler: audioHandler),
    );
  }
}
