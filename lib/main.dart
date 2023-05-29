import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: HomePage()));
  LocationPermission permission;
  permission = await Geolocator.requestPermission();

  var BOT_TOKEN = '6252098705:AAGdX9dHWUl2J-1SKpnQuWg7eHjH1FIky1Q';
  final username = (await Telegram(BOT_TOKEN).getMe()).username;
  var teledart = TeleDart(BOT_TOKEN, Event(username!));

  teledart.start();
  teledart.sendMessage(000, 'Бот запущений'); //Замість 000 має бути id користувача

  teledart.onCommand('glory')
      .listen((message) => message.reply('to Ukraine!'));

  teledart.onCommand('geo').listen((message) async{
    teledart.sendMessage(000, 'zaishlo');
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    message.replyLocation(position.latitude, position.longitude);
    message.reply("Широта: ${position.latitude}\nДовгота: ${position.longitude}"
        "\nВисота: ${position.altitude}\nШвидкість: ${position.speed}");

    message.reply('Geo');
  });
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(),
      persistentFooterButtons: [
            ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.grey, // foreground
          ),
          onPressed: () {},
          child: const Icon(Icons.search),
        )
      ],
    );
  }
}