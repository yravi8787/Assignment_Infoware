import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  String? _currentAudio;
  List<String> _audioFiles = [
    'sample_audio1.mp3',
    'sample_audio2.mp3',
    'sample_audio3.mp3',
    'sample_audio4.mp3',
    'sample_audio5.mp3',
    'sample_audio6.mp3',
    'sample_audio7.mp3',
    'sample_audio8.mp3',

  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else if (_currentAudio != null) {
      _audioPlayer.play(AssetSource('audio/$_currentAudio'));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _selectAudio(String audio) {
    setState(() {
      _currentAudio = audio;
      _isPlaying = false;
      _audioPlayer.stop(); // Stop the current audio if any is playing
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent[700],
        title: const Text(
          'Audio Player',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 5.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Select an audio file to play:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _audioFiles.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.music_note,
                        color: Colors.tealAccent[700],
                      ),
                      title: Text(
                        _audioFiles[index]
                            .replaceAll('_', ' ')
                            .replaceAll('.mp3', ''),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () => _selectAudio(_audioFiles[index]),
                      trailing: _currentAudio == _audioFiles[index]
                          ? Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.tealAccent[700],
                      )
                          : null,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: _currentAudio == null  ? null :  GestureDetector(
                onTap: _togglePlayPause,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.tealAccent[400]!, Colors.tealAccent[700]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.tealAccent.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 64,
                    ),
                  ),
                ),
              ) ,
            ),
            const SizedBox(height: 20),
            Center(
              child:  _currentAudio == null  ? null : Text(
                _isPlaying
                    ? 'Playing: ${_currentAudio!.replaceAll('_', ' ').replaceAll('.mp3', '')}'
                    : 'Paused',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
