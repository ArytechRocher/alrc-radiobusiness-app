import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';

class HomeScreen extends StatelessWidget {
  final AudioHandler audioHandler;
  const HomeScreen({required this.audioHandler, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ALRC Radio Business'), centerTitle: true),
      body: Center(
        child: StreamBuilder<PlaybackState>(
          stream: audioHandler.playbackState,
          builder: (context, snapshot) {
            final isPlaying = snapshot.data?.playing ?? false;
            return IconButton(
              iconSize: 64,
              color: Colors.deepPurple,
              icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle),
              onPressed: () => isPlaying ? audioHandler.pause() : audioHandler.play(),
            );
          },
        ),
      ),
    );
  }
}

