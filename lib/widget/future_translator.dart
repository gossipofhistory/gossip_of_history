import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class FutureTranslator extends StatelessWidget {
  late String text;
  GoogleTranslator translator = GoogleTranslator();

  FutureTranslator(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: translator.translate(text, to: "en"),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SelectableText("Something went wrong: ${snapshot.error}");
        }

        if (snapshot.hasData && snapshot.data!.text.isEmpty) {
          return SelectableText("No data found");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectableText(
                snapshot.data!.text == "" ? "Failed" : snapshot.data!.text,
                style: TextStyle(fontSize: 26)),
          );
        }
        return SelectableText("Please Wait");
      },
    );
    ;
  }
}
