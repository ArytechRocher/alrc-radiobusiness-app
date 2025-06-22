import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration.music());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALRC Radio Business',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
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
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  final String streamUrl =
      "https://groupemedia.info/uploads/udio/presenttion1.mp3";

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    try {
      await player.setUrl(streamUrl);
      player.playerStateStream.listen((state) {
        setState(() {
          isPlaying = state.playing;
        });
      });
    } catch (e) {
      print("Erreur de lecture: $e");
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Widget _buildWaveAnimation() {
    return isPlaying
        ? Icon(Icons.wifi_tethering, color: Colors.deepOrange, size: 50)
        : Icon(Icons.wifi_tethering_off, color: Colors.grey, size: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ALRC Radio Business'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Ajouté aux favoris !")),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://groupemedia.info/uploads/images/logo_radio.png",
              height: 120,
            ),
            const SizedBox(height: 20),
            Text(
              isPlaying ? "Lecture en cours..." : "En pause",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            _buildWaveAnimation(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Lire"),
                  onPressed: () => player.play(),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.pause),
                  label: const Text("Pause"),
                  onPressed: () => player.pause(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
