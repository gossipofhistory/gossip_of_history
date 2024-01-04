import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gossip_of_history/view_model/clickable_mzpb.dart';
import 'package:gossip_of_history/view_model/data.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapWidget extends StatelessWidget {
  late MapShapeSource shapeSource;
  MapShapeLayerController controller;
  ClickableMZPB mapZoomPanBehavior;
  late String src;
  int year;
  List<String?> countryList = [];
  List<String?> countryListTr = [];
  List<String?> countryListText = [];
  List<Color?> countryListColor = [];
  static String selectedCountry = "";
  static String selectedCountryText = "";
  MapLatLng selectedLatLng = MapLatLng(0, 0);
  static int index = -1;
  static int dataYear = -1;

  MapWidget(this.year, this.controller, this.mapZoomPanBehavior, {super.key}) {
    dataYear = year;
    switch (year) {
      case 1900:
        countryList = Data.mapList1900;
        countryListTr = Data.mapList1900tr;
        countryListColor = Data.mapColorList1900;
        src = "assets/world_1900.json";
        break;
      case 1914:
        countryList = Data.mapList1914;
        countryListTr = Data.mapList1914tr;
        countryListColor = Data.mapColorList1914;
        src = "assets/world_1914.json";
        break;
    }
    shapeSource = MapShapeSource.asset(
      src,
      shapeDataField: "NAME",
      dataCount: countryList.length,
      dataLabelMapper: (index) => countryListText[index] ?? "",
      primaryValueMapper: (index) => countryList[index] ?? "",
      shapeColorValueMapper: (index) =>
          countryListColor[index] ?? Color.fromRGBO(158, 158, 158, 1.0),
    );

    mapZoomPanBehavior.minZoomLevel = 2;
    mapZoomPanBehavior.maxZoomLevel = 10;
    mapZoomPanBehavior.zoomLevel = 3;
    mapZoomPanBehavior.focalLatLng = MapLatLng(50, 0);
    mapZoomPanBehavior.enableMouseWheelZooming = true;
    mapZoomPanBehavior.enableDoubleTapZooming = true;

    if (Data.switchVal) {
      countryListText = countryList;
    } else {
      countryListText = countryListTr;
    }
  }

  Widget build(BuildContext context) {
    mapZoomPanBehavior.onTap = (position) {
      selectedLatLng = controller.pixelToLatLng(position);
      if (selectedCountry.isNotEmpty) Navigator.pushNamed(context, "/info");
    };

    mapZoomPanBehavior.move = () {
      if (selectedCountry.isNotEmpty) MapWidget.selectedCountry = "";
    };

    return SfMaps(layers: [
      MapShapeLayer(
        source: shapeSource,
        controller: controller,
        showDataLabels: true,
        dataLabelSettings: const MapDataLabelSettings(
          textStyle: TextStyle(
            color: Colors.white,
            backgroundColor: Colors.black,
          ),
        ),
        loadingBuilder: (context) => const CircularProgressIndicator(),
        zoomPanBehavior: mapZoomPanBehavior,
        shapeTooltipBuilder: (context, index) {
          MapWidget.selectedCountry = countryList[index]??"";
          MapWidget.selectedCountryText = countryListText[index]??"";
          MapWidget.index = index;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                Icon(Icons.map, color: Colors.white, size: 16),
                Text(countryListText[index]??"",
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
          );
        },
        tooltipSettings: const MapTooltipSettings(
            color: Colors.blue,
            strokeColor: Color.fromRGBO(252, 187, 15, 1),
            strokeWidth: 1.5),
      )
    ]);
  }
}
