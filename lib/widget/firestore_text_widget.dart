import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gossip_of_history/view_model/data.dart';
import 'package:gossip_of_history/widget/future_translator.dart';
import 'package:translator/translator.dart';

class FirestoreTextWidget extends StatefulWidget {
  final String collection;
  final String document;
  final String field;
  final String countryText;
  String text = "";

  late CollectionReference collectionRef;

  FirestoreTextWidget(this.collection, this.document, this.field,
      {super.key, this.countryText = ""}) {
    collectionRef = FirebaseFirestore.instance.collection(collection);
  }

  @override
  State<FirestoreTextWidget> createState() => _FirestoreTextWidgetState();
}

class _FirestoreTextWidgetState extends State<FirestoreTextWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GoogleTranslator translator = GoogleTranslator();
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 4, 50, 50),
      child: FutureBuilder<DocumentSnapshot>(
        future: widget.collectionRef.doc(widget.document).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            if (Data.switchVal) {
              return SelectableText("Something went wrong: ${snapshot.error}");
            }
            return SelectableText("Bir şeyler ters gitti: ${snapshot.error}");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            if (Data.switchVal) {
              return SelectableText("No data found");
            }
            return SelectableText("Veri bulunamadı");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            List<Widget> trWidgetList = [];
            List<Widget> enWidgetList = [];
            if (widget.countryText.length > 0) {
              trWidgetList.add(Text(widget.countryText,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)));
              enWidgetList.add(FutureBuilder(
                future: translator.translate(widget.countryText, to: "en"),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return SelectableText(
                        "Something went wrong: ${snapshot.error}");
                  }

                  if (snapshot.hasData && snapshot.data!.text.isEmpty) {
                    return SelectableText("No data found");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(snapshot.data!.text,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold));
                  }
                  return SelectableText("Please Wait");
                },
              ));
            }

            String inputString = data[widget.field].toString();
            inputString = inputString.replaceAll("\\n", "\n");
            RegExp regex = RegExp(r"([^*]+)");
            List<String?> list = regex
                .allMatches(inputString)
                .map((match) => match.group(0))
                .toList();
            String s = "";
            for (var element in list) {
              element ??= "";
              if (element.trim().startsWith("<")) {
                trWidgetList.add(selectable(s));
                if (s != "") enWidgetList.add(FutureTranslator(s));
                s = "";
                trWidgetList.add(Center(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.width / 3,
                      child: HtmlWidget(element)),
                ));
                enWidgetList.add(Center(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.width / 3,
                      child: HtmlWidget(element)),
                ));
              } else {
                s += element;
              }
            }
            trWidgetList.add(selectable(s));
            if (s != "") enWidgetList.add(FutureTranslator(s));

            if (Data.switchVal) {
              if (enWidgetList.length > 0)
                return Card(
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Column(children: enWidgetList)),
                    ));
            } else {
              if (trWidgetList.length > 0)
                return Card(
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Column(children: trWidgetList)),
                    ));
            }
          }

          if (Data.switchVal) {
            return SelectableText("Please Wait");
          }
          return SelectableText("Lütfen Bekleyiniz");
        },
      ),
    );
  }

  selectable(String s) {
    String goh = "GOSSIP OF HISTORY";
    if (s.startsWith(goh))
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/logobgwhite.jpg"),
                  opacity: 0.3,
                  scale: 0.5),
            ),
            child: SelectableText(s, style: TextStyle(fontSize: 26))),
      );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          Container(child: SelectableText(s, style: TextStyle(fontSize: 26))),
    );
  }
}
