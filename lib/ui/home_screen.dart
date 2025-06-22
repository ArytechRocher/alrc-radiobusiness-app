import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final handler = AudioServiceHandlerProvider.of(context);
    final playing = AudioService.playbackState
        .map((state) => state.playing)
        .distinct();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ALRC Radio Business'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            .network(
            "https://groupemedia.info/uploads/images/logo_radio.png",
            height: 120,
          ),
            const SizedBox(height: 20),
            const Text(
              'En direct depuis ALRC Radio',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            StreamBuilder<bool>(
              stream: playing,
              builder: (context, snapshot) {
                final isPlaying = snapshot.data ?? false;
                return IconButton(
                  iconSize: 64,
                  color: Colors.deepPurple,
                  icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle),
                  onPressed: () => isPlaying
                      ? handler.pause()
                      : handler.play(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AudioServiceHandlerProvider extends InheritedWidget {
  final AudioHandler handler;
  const AudioServiceHandlerProvider({
    required this.handler,
    required super.child,
    super.key,
  });

  static AudioHandler of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AudioServiceHandlerProvider>();
    assert(result != null, 'No AudioServiceHandlerProvider found in context');
    return result!.handler;
  }

  @override
  bool updateShouldNotify(AudioServiceHandlerProvider oldWidget) => false;
}
