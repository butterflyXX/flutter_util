import 'package:flutter/material.dart';

mixin EntryAble {
  OverlayEntry? entry;
  void show() {

  }
  void hidden() {
    entry?.remove();
    entry = null;
  }
}