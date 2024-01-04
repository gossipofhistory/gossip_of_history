import 'package:flutter/material.dart';
import 'package:gossip_of_history/view_model/clickable_mzpb.dart';
import 'package:gossip_of_history/view_model/data.dart';
import 'package:gossip_of_history/widget/header_widget.dart';
import 'package:gossip_of_history/widget/map_widget.dart';

import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  MapShapeSource? shapeSource;

  DateTime dateValue = DateTime(1900);
  late Widget map;
  late Widget map1900;
  late Widget map1914;
  late Widget map1920;
  bool changed1900 = true;
  bool changed1914 = false;
  bool changed1920 = false;

  @override
  void initState() {
    MapShapeLayerController controller = MapShapeLayerController();
    ClickableMZPB mapZoomPanBehavior = ClickableMZPB();

    map1900 = new MapWidget(1900, controller, mapZoomPanBehavior);
    map1914 = new MapWidget(1914, controller, mapZoomPanBehavior);
    // map1920 = new MapWidget(1920, controller, mapZoomPanBehavior);
    setState(() {
      map = map1900;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = Data.menuTr.indexOf("Harita");
    String title = Data.switchVal ? Data.menuEn[index] : Data.menuTr[index];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Title(
        color: Colors.black,
        title: title,
        child: Column(
          children: [
            HeaderWidget(),
            Flexible(flex: 1, child: map),
            slider(),
          ],
        ),
      ),
    );
  }

  Widget slider() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SfSlider(
        value: dateValue,
        min: DateTime(1900),
        max: DateTime(1919),
        showLabels: true,
        dateFormat: DateFormat.y(),
        showTicks: true,
        interval: 7,
        enableTooltip: true,
        dateIntervalType: DateIntervalType.years,
        onChanged: (value) {
          setState(() {
            dateValue = value;
            int year = dateValue.year;
            if (year >= 1900 && year < 1914 && !changed1900) {
              setState(() {
                map = map1900;
                changed1900 = true;
                changed1914 = false;
                changed1920 = false;
              });
            } else if (year >= 1914 && year < 1920 && !changed1914) {
              setState(() {
                map = map1914;
                changed1900 = false;
                changed1914 = true;
                changed1920 = false;
              });
            } else if (year >= 1920 && year < 1922 && !changed1920) {
              setState(() {
                map = map1920;
                changed1900 = false;
                changed1914 = false;
                changed1920 = true;
              });
            }
          });
        },
      ),
    );
  }
}
