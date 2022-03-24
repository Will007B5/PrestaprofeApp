import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/helpers/helpers.dart';
import 'package:prestaprofe/src/services/clients_service.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class StepThreeFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Variable que permite obtener los argumentos que se le pasaron a este componente al momento de llamarlo por medio de su ruta
    final _routeArgumentsTypeImage =
        ModalRoute.of(context)!.settings.arguments as String;

    return SafeArea(
      top: false,
      child: Scaffold(
          appBar: AppBar(elevation: 0),
          body: Container(
            color: Colors.white,
            height: double.infinity,
            width: double.infinity,
            child: CustomScrollView(slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          RegisterFileImage(imageType: _routeArgumentsTypeImage),
                          // Positioned(
                          //   bottom: 7,
                          //   right: 139,
                          //   child: TextButton(
                          //     onPressed: () => Navigator.of(context).pop(),
                          //     child: Text('GUARDAR', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          //     style: ButtonStyle(
                          //       backgroundColor: MaterialStateProperty.all<Color>(
                          //         Color.fromRGBO(51, 114, 134, 0.85)
                          //       ),
                          //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          //         RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10.0),
                          //           side: BorderSide(color: Color.fromRGBO(51, 114, 134, 1))
                          //         )
                          //       )
                          //     )
                          //   )
                          // ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Column(children: [
                        _CardOptions(
                            routeArgumentsTypeImage: _routeArgumentsTypeImage),
                      ])
                    ],
                  ),
                ),
              )
            ]),
          )),
    );
  }
}

class _CardOptions extends StatelessWidget {
  final String routeArgumentsTypeImage;

  _CardOptions({Key? key, required this.routeArgumentsTypeImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mediaQuerySize = MediaQuery.of(context).size;
    final _height = _mediaQuerySize.height;
    final _width = _mediaQuerySize.width;
    final _textWidth = _width * 0.04;
    final _iconSize = (_height * _width) * 0.000084;

    final options = {
      {
        "icon": Icons.camera_alt_rounded,
        "text": "Tomar fotografía",
        "action": "camera"
      },
      {
        "icon": Icons.photo_rounded,
        "text": "Seleccionar de la galería",
        "action": "gallery"
      },
      {
        "icon": Icons.picture_as_pdf_rounded,
        "text": "Seleccionar archivo .pdf",
        "action": "file"
      }
    };

    final List<Widget> listOptions = [];

    options.forEach((opt) {
      final widgetTemp = GestureDetector(
        onTap: () async {
          await _makeActionFromSelectedOption(
              context, this.routeArgumentsTypeImage, opt['action'].toString());
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Color.fromRGBO(255, 255, 255, 0.94),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(51, 114, 134, 1),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    visualDensity: VisualDensity.compact,
                    dense: true,
                    title: Text(opt['text'].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: _textWidth)),
                    subtitle: Icon(opt['icon'] as IconData,
                        color: Color.fromRGBO(51, 114, 134, 1),
                        size: _iconSize),
                  )
                ],
              ),
            ),
          ),
        ),
      );
      if (this.routeArgumentsTypeImage != 'selfie') {
        listOptions.add(widgetTemp);
      } else if (this.routeArgumentsTypeImage == 'selfie') {
        if (opt['action'].toString() == 'camera') {
          listOptions.add(widgetTemp);
        }
      }
    });

    return Container(
        width: double.infinity, child: Column(children: listOptions));
  }

  //Metodo que manipula multimedia de acuerdo a la opcion seleccionada
  Future<void> _makeActionFromSelectedOption(BuildContext context,
      String routeArgumentsTypeImage, String action) async {
    final ImagePicker _imagePicker = ImagePicker();
    final _clientsService = Provider.of<ClientsService>(context, listen: false);
    final _registerForm = Provider.of<RegisterFormProvider>(context, listen: false);
    final response =
        await PermissionsHelper.requestForPermission(permissionType: 'camera');
    if (response == 200) {
      if (action == 'gallery') {
        // try {
        //   FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        //       type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png']);

        //   if (pickedFile == null) {
        //     return;
        //   }

        //   print(
        //       'Hay que hacer que archivo se vea ${pickedFile.files.single.path!}');
        //   _clientsService.updateImagesPreview(
        //       routeArgumentsTypeImage, pickedFile.files.single.path!);
        // } catch (e) {}
        try {
          final XFile? pickedFile = await ImagePicker()
              .pickImage(source: ImageSource.gallery, imageQuality: 70);
          //await _imagePicker.retrieveLostData();
          print('pickedFile');
          if (pickedFile == null) {
            return;
          }

          print('Hay que hacer que imagen se vea ${pickedFile.path}');
          final responsePath = await _clientsService.updateImagesPreview(routeArgumentsTypeImage, pickedFile.path);
          if(responsePath != null){
            _assignImageToClient(context, routeArgumentsTypeImage, responsePath);
          }
        } catch (e) {
          print(e);
        }
      } else if (action == 'camera') {
        try {
          final XFile? pickedFile = await ImagePicker()
              .pickImage(source: ImageSource.camera, imageQuality: 70);
          //await _imagePicker.retrieveLostData();
          print('pickedFile');
          if (pickedFile == null) {
            return;
          }

          print('Hay que hacer que imagen se vea ${pickedFile.path}');
          final responsePath = await _clientsService.updateImagesPreview(routeArgumentsTypeImage, pickedFile.path);
          if(responsePath != null){
            _assignImageToClient(context, routeArgumentsTypeImage, responsePath);
          }
        } catch (e) {
          print(e);
        }
      } else if (action == 'file') {
        try {
          FilePickerResult? pickedFile = await FilePicker.platform
              .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

          if (pickedFile == null) {
            return;
          }
          print(
              'Hay que hacer que archivo se vea ${pickedFile.files.single.path!}');
          final responsePath = await _clientsService.updateImagesPreview(routeArgumentsTypeImage, pickedFile.files.single.path!);
          if(responsePath != null){
            _assignImageToClient(context, routeArgumentsTypeImage, responsePath);
          }
        } catch (e) {}
      }
    }
  }

  void _assignImageToClient(BuildContext context, String imageType, String path){
    final _registerForm = Provider.of<RegisterFormProvider>(context, listen: false);
    if (imageType == 'ine') {
      _registerForm.client.ine = path;
    }
    else if (imageType == 'ineBack') {
      _registerForm.client.ineBack = path;
    } else if (imageType == 'selfie') {
      _registerForm.client.selfie = path;
    } else if (imageType == 'proofAddress') {
      _registerForm.client.proofAddress = path;
    } else if (imageType == 'payStub') {
      _registerForm.client.payStub = path;
    }
    _registerForm.refreshListeners();
  }
}



