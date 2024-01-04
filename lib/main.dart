import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gossip_of_history/firebase_options.dart';
import 'package:gossip_of_history/view/about_view.dart';
import 'package:gossip_of_history/view/contact_view.dart';
import 'package:gossip_of_history/view/info_view.dart';
import 'package:gossip_of_history/view/main_view.dart';
import 'package:gossip_of_history/view/map_view.dart';
import 'package:gossip_of_history/view/source_view.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Gramond"),
      debugShowCheckedModeBanner: false,
      title: "Gossip Of History",
      initialRoute: "/",
      routes: {
        "/": (context) => MainView(),
        "/map": (context) => MapView(),
        "/info": (context) => InfoView(),
        "/about": (context) => AboutView(),
        "/contact": (context) => ContactView(),
        "/source": (context) => SourceView(),
      },
    );
  }
}
