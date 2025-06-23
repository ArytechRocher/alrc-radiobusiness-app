import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class MyAudioHandler extends BaseAudioHandler with SeekHandler {
  final _player = AudioPlayer();

  MyAudioHandler() {
    _notifyAudioHandlerAboutPlaybackEvents();
    _listenForDurationChanges();
    _listenForCurrentSongIndexChanges();

    // Lecture automatique du flux à l'initialisation (si désiré)
    _init();
  }

  Future<void> _init() async {
    final mediaItem = MediaItem(
      id: 'https://groupemedia.info/uploads/audio/presentation1.mp3',
      album: "ALRC Radio",
      title: "Présentation Radio Business",
      artist: "ALRC Groupe Média",
      duration: const Duration(minutes: 3),
      artUri: Uri.parse('https://groupemedia.info/uploads/images/logo_radio.png'),
    );

    mediaItemSubject.add(mediaItem);
    await _player.setAudioSource(AudioSource.uri(Uri.parse(mediaItem.id)));
  }

  void _notifyAudioHandlerAboutPlaybackEvents() {
    _player.playbackEventStream.listen((event) {
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          _player.playing ? MediaControl.pause : MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        androidCompactActionIndices: const [0, 1, 3],
        processingState: _transformProcessingState(_player.processingState),
        playing: _player.playing,
        position: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        updateTime: DateTime.now(),
      ));
    });
  }

  void _listenForDurationChanges() {
    _player.durationStream.listen((duration) {
      final currentMediaItem = mediaItem.value;
      if (currentMediaItem != null && duration != null) {
        mediaItem.add(currentMediaItem.copyWith(duration: duration));
      }
    });
  }

  void _listenForCurrentSongIndexChanges() {
    _player.currentIndexStream.listen((index) {
      // Si tu veux gérer une playlist ici
    });
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() async {
    // à implémenter si playlist
  }

  @override
  Future<void> skipToPrevious() async {
    // à implémenter si playlist
  }

  AudioProcessingState _transformProcessingState(ProcessingState state) {
    switch (state) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
    }
  }
}
