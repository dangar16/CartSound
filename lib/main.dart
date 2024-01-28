import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyPage(),
      theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
              color: Colors.black12,
              iconTheme: IconThemeData(color: Colors.white)),
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue, brightness: Brightness.dark)),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final AudioPlayer player = AudioPlayer();

  static const alarmLock = "GateKeeperCartKeyLock78.wav";
  static const alarmUnlock = "unlock-cart.wav";

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> playAudioFromSource(String audioSource) async {
    await player.setVolume(1);
    await player.play(AssetSource(audioSource));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Sonido carros"),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.shopping_cart),
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            ElevatedButton.icon(
              onPressed: () {
                playAudioFromSource(alarmLock);
              },
              label: const Text(
                "Bloquear",
              ),
              icon: const Icon(Icons.lock_outline),
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(160.0)),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
                icon: const Icon(Icons.lock_open),
                onPressed: () {
                  playAudioFromSource(alarmUnlock);
                },
                label: const Text("Desbloquear"),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromWidth(160.0))),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Reproduzca el audio cerca de la rueda para que funcione correctamente.",
              textAlign: TextAlign.center,
            ),
          ]),
        ),
      ),
    );
  }
}
