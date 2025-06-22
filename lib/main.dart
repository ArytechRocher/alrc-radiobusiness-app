import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALRC Radio Business',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _startAudio();
  }

  Future<void> _startAudio() async {
    await player.setLoopMode(LoopMode.one);
    await player.setUrl("https://groupemedia.info/uploads/udio/presenttion1.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ALRC Radio Business")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://groupemedia.info/uploads/images/logo_radio.png",
              height: 150,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
            ),
            const SizedBox(height: 20),
            const Text("Bienvenue sur la Radio Business"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => player.play(),
              child: const Text("▶️ Lancer la lecture"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => player.pause(),
              child: const Text("⏸️ Pause"),
            )
          ],
        ),
      ),
    );
  }
}
