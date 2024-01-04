import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class ClickableMZPB extends MapZoomPanBehavior {
  late MapTapCallback onTap;
  late MapMoveCallback move;

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerUpEvent) {
      onTap(event.localPosition);
    }

    if (event is PointerMoveEvent) {
      move();
    }
    super.handleEvent(event);
  }
}

typedef MapTapCallback = void Function(Offset position);
typedef MapMoveCallback = void Function();
