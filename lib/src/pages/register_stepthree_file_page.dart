import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:prestaprofe/src/widgets/widgets.dart';


class StepThreeFile extends StatelessWidget {

  String _selectedOptPopUpMenu = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    RegisterFileImage(),
                    Positioned(
                      top: 13,
                      right: 13,
                      child: PopupMenuButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        onSelected: (result) async {
                          if(result.toString() == 'gallery'){
                            final imagePicker = new ImagePicker();
                            final XFile? pickedFile = await imagePicker.pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 100
                            );
                        
                            if(pickedFile == null){
                              return;
                            }
                        
                            print('Hay que hacer que imagen se vea ${pickedFile.path}');
                          }
                        },
                        itemBuilder: (BuildContext context){
                          final List<PopupMenuEntry> list = [
                            PopupMenuItem(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.camera_alt_rounded, color: Color.fromRGBO(51, 114, 134, 1)),
                                  Text('Tomar fotografía')
                                ],
                              ),
                              value: 'camera',
                            ),
                            PopupMenuItem(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.photo_rounded, color: Color.fromRGBO(51, 114, 134, 1)),
                                  Text('Seleccionar de la galería')
                                ],
                              ),
                              value: 'gallery',
                            ),
                            PopupMenuItem(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.picture_as_pdf_rounded, color: Color.fromRGBO(51, 114, 134, 1)),
                                  Text('Seleccionar archivo .pdf')
                                ],
                              ),
                              value: 'file',
                            )
                          ];
                          return list;
                        },
                        icon: Icon(Icons.more_vert_rounded, size: 35, color: Colors.white),
                        iconSize: 35,
                      ),
                    ),
                  ]
                ),
                //_RecomendationsAd()
              ],
            ),
          ),
        )
      ),
    );
  }
}

class _RecomendationsAd extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Column(
          children: [
            SizedBox(height: 15),
            Text('Capture una nueva fotografía o seleccione alguna de la galería', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.85)), textAlign: TextAlign.center),
            SizedBox(height: 15),
            Text('- La imágen debe de ser clara', style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.85))),
            SizedBox(height: 5),
            Text('- La información debe ser reciente', style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.85))),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Color.fromRGBO(51, 114, 134, 0.9),
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
    );
  }
}