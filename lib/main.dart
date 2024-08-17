import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

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
  double _value = 0;

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
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                      customWidths: CustomSliderWidths(
                          trackWidth: 10.0, handlerSize: 10.0),
                      customColors: CustomSliderColors(trackColor: Colors.red),
                      infoProperties: InfoProperties(
                          mainLabelStyle: const TextStyle(color: Colors.red))),
                  initialValue: 0,
                  onChange: (value) => {
                    setState(() {
                      _value = value;
                    })
                  },
                  min: 0,
                  max: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          playAudioFromSource(alarmLock, _value);
                        },
                        icon: const Icon(Icons.lock)),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                        onPressed: () {
                          playAudioFromSource(alarmUnlock, _value);
                        },
                        icon: const Icon(Icons.lock_open)),
                  ],
                ),
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
