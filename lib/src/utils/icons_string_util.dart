import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'camera_alt' : Icons.camera_alt
};

Icon getIcon(String nameIcon){
  return Icon(_icons[nameIcon]);
}