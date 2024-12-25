import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart'; // Import just_audio

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Kirtan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Live Kirtan'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AudioPlayer _audioPlayer = AudioPlayer(); // Use just_audio's AudioPlayer
  bool isPlaying = false;
  final String liveKirtanUrl = 'https://live.sgpc.net:8444/;'; // Replace with your live URL

  // Function to toggle play/pause
  Future<void> _togglePlayPause() async {

    if (isPlaying) {
      isPlaying = !isPlaying;
      setState(() {
      });
      await _audioPlayer.pause();

    } else {
      try {
        isPlaying = !isPlaying;
        setState(() {
        });
        await _audioPlayer.setUrl(liveKirtanUrl);  // Set the URL for the live audio stream
        await _audioPlayer.play();  // Start playing

      } catch (e) {
        print("Error loading stream: $e");
      }
    }


  }

  @override
  void dispose() {
    _audioPlayer.dispose();  // Dispose of the player when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(97,65,13, 1.0),
        title: Text(widget.title, style: TextStyle(color:Color.fromRGBO(232,187,1,  1.0), fontWeight: FontWeight.bold),),

      ),
      body: Container(
        height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpg'), // Correct usage of AssetImage
              fit: BoxFit.cover, // Adjust how the image fits within the container
            ),
          ),

        child:
        Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            const SizedBox(height: 250),

            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _togglePlayPause,
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,size: 45, color: Color.fromRGBO(232,187,1,  1.0),),
              label: Text(isPlaying ? 'Pause' : 'Play', style: TextStyle(fontSize: 30),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(97,65,13, 1.0),
                foregroundColor: Color.fromRGBO(232,187,1,  1.0),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
