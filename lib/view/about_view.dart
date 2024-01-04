import 'package:flutter/material.dart';
import 'package:gossip_of_history/view_model/data.dart';
import 'package:gossip_of_history/widget/firestore_text_widget.dart';
import 'package:gossip_of_history/widget/header_widget.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    int index = Data.menuTr.indexOf("Hakkımızda");
    String title = Data.switchVal ? Data.menuEn[index] : Data.menuTr[index];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Title(
        color: Colors.black,
        title: title,
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidget(),
              FirestoreTextWidget("view", "about", "text"),
            ],
          ),
        ),
      ),
    );
  }
}
