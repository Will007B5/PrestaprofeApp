import 'package:flutter/material.dart';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
    static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    static String? uniqueDeviceName;

    static Future initializeDeviceInfo() async {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      uniqueDeviceName = '${androidInfo.manufacturer}-${androidInfo.model}-${androidInfo.androidId}';
      print('DISPOTIVO: $uniqueDeviceName');
    }

}