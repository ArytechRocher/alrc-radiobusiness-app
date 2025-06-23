import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';

class HomeScreen extends StatelessWidget {
  final AudioHandler audioHandler;
  const HomeScreen({required this.audioHandler, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        title: const Text('🎙️ ALRC Radio Business'),
        backgroundColor: const Color(0xFF3E3E3E),
        centerTitle: true,
        elevation: 4,
      ),
      body: Center(
        child: StreamBuilder<PlaybackState>(
          stream: audioHandler.playbackState,
          builder: (context, snapshot) {
            final isPlaying = snapshot.data?.playing ?? false;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: isPlaying ? 120 : 100,
                  height: isPlaying ? 120 : 100,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: NetworkImage('https://groupemedia.info/uploads/images/logo_radio.png'),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.4),
                        blurRadius: 12,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                IconButton(
                  iconSize: 80,
                  color: Colors.deepPurpleAccent,
                  icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill),
                  onPressed: () => isPlaying ? audioHandler.pause() : audioHandler.play(),
                ),
                const SizedBox(height: 16),
                Text(
                  isPlaying ? "En cours de lecture..." : "Lecture en pause",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
