import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'background_audio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final audioHandler = await AudioService.init(
    builder: () => RadioAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.alrc.radio.channel.audio',
      androidNotificationChannelName: 'ALRC Radio Business',
      androidNotificationOngoing: true,
    ),
  );
  runApp(ALRCRadioApp(audioHandler: audioHandler));
}

class ALRCRadioApp extends StatelessWidget {
  final AudioHandler audioHandler;
  const ALRCRadioApp({super.key, required this.audioHandler});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALRC Radio Business',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("ALRC Radio Business")),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              audioHandler.play();
            },
            child: const Text("Écouter en direct"),
          ),
        ),
      ),
    );
  }
}
