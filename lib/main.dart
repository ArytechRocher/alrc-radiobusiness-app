import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALRC Radio Business',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const RadioHomePage(),
    );
  }
}

class RadioHomePage extends StatefulWidget {
  const RadioHomePage({super.key});
  @override
  State<RadioHomePage> createState() => _RadioHomePageState();
}

class _RadioHomePageState extends State<RadioHomePage> {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;

  final String streamUrl = "https://groupemedia.info/uploads/audio/presentation1.mp3";

  @override
  void initState() {
    super.initState();
    _player.playerStateStream.listen((state) {
      setState(() {
        isPlaying = state.playing;
      });
    });
  }

  Future<void> play() async {
    try {
      await _player.setUrl(streamUrl);
      await _player.play();
    } catch (e) {
      debugPrint("Erreur lors de la lecture: $e");
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ALRC Radio Business"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "https://groupemedia.info/uploads/images/logo_radio.png",
            height: 120,
          ),
          const SizedBox(height: 20),
          Icon(
            isPlaying ? Icons.wifi_tethering : Icons.wifi_off,
            size: 60,
            color: isPlaying ? Colors.orange : Colors.grey,
          ),
          const SizedBox(height: 20),
          Text(
            isPlaying ? "Lecture en cours..." : "Appuyez pour démarrer",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text("Lire"),
                onPressed: play,
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.pause),
                label: const Text("Pause"),
                onPressed: pause,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
