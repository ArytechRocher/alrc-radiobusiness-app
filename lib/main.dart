import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio_background/just_audio_background.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.alrc.radio.channel.audio',
    androidNotificationChannelName: 'ALRC Radio Audio',
    androidNotificationOngoing: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALRC Radio Business',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: RadioPlayerPage(),
    );
  }
}

class RadioPlayerPage extends StatefulWidget {
  @override
  _RadioPlayerPageState createState() => _RadioPlayerPageState();
}

class _RadioPlayerPageState extends State<RadioPlayerPage> {
  final player = AudioPlayer();
  bool isPlaying = false;

  // 🔊 Remplace par ton vrai flux radio ici :
  final String streamUrl = 'asset:assets/images/logo_radio.png';

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await player.setAudioSource(AudioSource.uri(Uri.parse(streamUrl),
        tag: MediaItem(
          id: streamUrl,
          title: "ALRC Radio Business",
          artist: "ALRC Groupe Média",
          artUri: Uri.parse('asset:assets/images/logo_radio.png'), // ✅ Logo dans notif
        ),
      ));
    } catch (e) {
      print("Erreur lors du chargement du flux audio: $e");
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (player.playing) {
      player.pause();
      setState(() => isPlaying = false);
    } else {
      player.play();
      setState(() => isPlaying = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ALRC Radio Business'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.radio, size: 100, color: Colors.redAccent),
            SizedBox(height: 20),
            Text(
              'Écoutez la radio en direct',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _togglePlayPause,
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              label: Text(isPlaying ? "Pause" : "Lecture"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
