import 'package:flutter/material.dart';
import 'package:gossip_of_history/view_model/data.dart';
import 'package:gossip_of_history/widget/firestore_text_widget.dart';
import 'package:gossip_of_history/widget/header_widget.dart';
import 'package:gossip_of_history/widget/map_widget.dart';
import 'package:translator/translator.dart';

class InfoView extends StatelessWidget {
  InfoView({super.key});

  @override
  Widget build(BuildContext context) {
    GoogleTranslator translator = GoogleTranslator();
    String country = MapWidget.selectedCountry;
    if (country.isEmpty) Navigator.popAndPushNamed(context, "/");
    String countryText = MapWidget.selectedCountryText;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Title(
        title: country,
        color: Colors.black,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/main_background.jpg"),
                fit: BoxFit.fill),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderWidget(),
                const SizedBox(
                  height: 8,
                ),
                FirestoreTextWidget(
                  "map",
                  country,
                  "info",
                  countryText: countryText,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
