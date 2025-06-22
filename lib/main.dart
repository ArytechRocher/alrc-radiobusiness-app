import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'audio_player_handler.dart';
import 'ui/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final audioHandler = await initAudioService();
  runApp(MyApp(audioHandler));
}

class MyApp extends StatelessWidget {
  final AudioHandler audioHandler;
  const MyApp(this.audioHandler, {super.key});

  @override
  Widget build(BuildContext context) {
    return AudioServiceHandlerProvider(
      handler: audioHandler,
      child: MaterialApp(
        title: 'ALRC Radio Business',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          appBarTheme: const AppBarTheme(centerTitle: true),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

