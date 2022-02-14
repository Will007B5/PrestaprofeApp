import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prestaprofe/src/services/services.dart';

class PermissionsHelper {
  static Future<int> requestForPermission({
    required String permissionType, //permissionType es el tipo de permiso que se requiere
  }) async {
    return await _askPermissions(permissionType);
  }

  static Future<int> _askPermissions(String permissionType) async {
    switch(permissionType){
      case 'contacts':
        PermissionStatus permissionStatus = await _getContactPermission();
        if (permissionStatus == PermissionStatus.granted) {
          //NotificationsService.showSnackbar('Acceso concedido a los contactos del dispositivo', 'success');
          return 200;
        } else {
          _handleInvalidPermissions(permissionStatus);
          return 400;
        }
      case 'camera':
        PermissionStatus permissionStatus = await _getCameraPermission();
        if (permissionStatus == PermissionStatus.granted) {
          //NotificationsService.showSnackbar('Acceso concedido a la camara del dispositivo', 'success');
          return 200;
        } else {
          _handleInvalidPermissions(permissionStatus);
          return 400;
        }
    }
    return 400;
  }

  static void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      //Manda errores
      NotificationsService.showSnackbar('Permiso denegado', 'error');
      //ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      NotificationsService.showSnackbar('Permiso denegado permanentemente', 'error');
    }
  }

  static Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  static Future<PermissionStatus> _getCameraPermission() async {
    PermissionStatus permission = await Permission.camera.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.camera.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }
}