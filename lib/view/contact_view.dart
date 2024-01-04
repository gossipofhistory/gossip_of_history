import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gossip_of_history/view_model/data.dart';
import 'package:gossip_of_history/widget/firestore_text_widget.dart';
import 'package:gossip_of_history/widget/header_widget.dart';
import 'package:latlong2/latlong.dart';
import 'dart:js' as js;

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    int index = Data.menuTr.indexOf("İletişim");
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
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                children: [
                  map(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    verticalDirection: VerticalDirection.down,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      iconButton(
                          Icons.language,
                          "http://osmaniyesbl.meb.k12.tr/",
                          "http://osmaniyesbl.meb.k12.tr/"),
                      iconButton(Icons.phone_enabled, "0 328 825 6401",
                          "tel:+903288256401"),
                      iconButton(
                          Icons.location_pin,
                          "FAKIUŞAĞI MAH. LİSELER KAMPÜSÜ 45102 Sokak\nDış Kapı No 4 /8 MERKEZ/OSMANİYE",
                          "https://maps.app.goo.gl/5jQRK3wysiSC2bwr7"),
                      iconButton(FontAwesomeIcons.instagram, "Instagram",
                          "https://www.instagram.com/tarihtekibilinmeyenler/"),
                    ],
                  )
                ],
              ),
              // FirestoreTextWidget("view", "contact", "text")
            ],
          ),
        ),
      ),
    );
  }

  map() {
    MapController controller = MapController();
    LatLng latLng = LatLng(37.054131, 36.228505);
    double zoom = 14;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            IconButton(
                onPressed: () => controller.move(latLng, ++zoom),
                icon: Icon(Icons.add)),
            IconButton(
                onPressed: () => controller.move(latLng, --zoom),
                icon: Icon(Icons.remove)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 400,
            height: 400,
            child: FlutterMap(
              options: MapOptions(center: latLng, zoom: zoom),
              mapController: controller,
              children: [
                TileLayer(
                    urlTemplate:
                        "https://mt0.google.com/vt/lyrs=m@221097413,traffic,transit,bike&x={x}&y={y}&z={z}"),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: latLng,
                      width: 80,
                      height: 80,
                      builder: (BuildContext context) =>
                          Icon(Icons.location_pin, color: Colors.red, size: 50),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  iconButton(IconData icon, String text, String url) {
    VoidCallback? onPressed;
    if (url.isNotEmpty) {
      onPressed = () => js.context.callMethod("open", [url]);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.black),
        label: Text(
          text,
          style: TextStyle(color: Colors.black),
        ),
        style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent)),
      ),
    );
  }
}
