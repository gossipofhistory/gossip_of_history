import 'package:flutter/material.dart';
import 'dart:js' as js;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gossip_of_history/view_model/data.dart';

class HeaderWidget extends StatefulWidget {
  late List<String> menu;

  HeaderWidget({super.key}) {
    if (Data.switchVal) {
      menu = Data.menuEn;
    } else {
      menu = Data.menuTr;
    }
  }

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        color: Color(0xff333333),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.popAndPushNamed(context, "/"),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    logo(),
                    Image.asset("assets/school.jpg", width: 50, height: 50),
                  ],
                ),
              ),
            ),
            switchButton(),
          ],
        ),
      ),
      Container(
        color: Color(0xff444444),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

              ),
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                textButton(widget.menu[0], "/"),
                textButton(widget.menu[1], "/map"),
                textButton(widget.menu[2], "/about"),
                textButton(widget.menu[4], "/source"),
                textButton(widget.menu[5],
                    "https://firebasestorage.googleapis.com/v0/b/gossip-of-history.appspot.com/o/eguvenlik.pdf?alt=media&token=32ce367b-645b-4152-9462-ac823dc9151f"),
                textButton(widget.menu[3], "/contact"),
                instagramButton(),
              ],
            ),
          ],
        ),
      ),
    ]);
  }

  image(String path) {
    return SizedBox(width: 50, height: 50, child: Image.asset(path));
  }

  textButton(String text, routeName) {
    return TextButton(
        onPressed: () {
          if (routeName.startsWith("http")) {
            js.context.callMethod("open", [routeName]);
          } else {
            Navigator.popAndPushNamed(context, routeName);
          }
        },
        child: Text(text, style: TextStyle(color: Colors.white,fontSize: 20)));
  }

  instagramButton() {
    return IconButton(
        onPressed: () {
          js.context.callMethod(
              "open", ["https://www.instagram.com/tarihtekibilinmeyenler/"]);
        },
        icon: Icon(FontAwesomeIcons.instagram, color: Colors.white));
  }

  logo() {
    return TextButton.icon(
      style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent)),
      onPressed: () => Navigator.popAndPushNamed(context, "/"),
      icon: Image.asset("assets/logo.jpg", width: 50, height: 50),
      label: Text("Gossip Of History",
          style: TextStyle(
              fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  switchButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Türkçe", style: TextStyle(color: Colors.white)),
        Switch(
          activeColor: Colors.white,
          activeTrackColor: Colors.white,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.white,
          value: Data.switchVal,
          onChanged: (value) {
            setState(() {
              Data.switchVal = value;
              if (value) {
                widget.menu = Data.menuEn;
              } else {
                widget.menu = Data.menuTr;
              }
              Navigator.popAndPushNamed(
                  context, ModalRoute.of(context)!.settings.name!);
            });
          },
        ),
        Text("English", style: TextStyle(color: Colors.white))
      ],
    );
  }
}
