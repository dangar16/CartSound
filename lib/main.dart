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
  double _value = 1;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> playAudioFromSource(String audioSource, double volume) async {
    await player.setVolume(volume);
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
            Image.asset(
              'assets/shopping_cart.png',
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Control de Carros",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            playAudioFromSource(alarmLock, _value);
                          },
                          icon: const Icon(Icons.lock),
                          label: const Text("Bloquear"),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            playAudioFromSource(alarmUnlock, _value);
                          },
                          icon: const Icon(Icons.lock_open),
                          label: const Text("Desbloquear"),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Volumen",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      value: _value,
                      min: 0.0,
                      max: 1.0,
                      divisions: 10,
                      label: "${(_value * 100).toStringAsFixed(0)}%",
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Reproduzca el audio cerca de la rueda para que funcione correctamente.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
