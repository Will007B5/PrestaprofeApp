import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:path/path.dart' as fileextension;
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/helpers/helpers.dart';
import 'package:prestaprofe/src/services/services.dart';
class RegisterFileImage extends StatelessWidget {

  final String imageType; //Recibe un parametro que es el tipo de imagen (ine, ineBack, selfie, proofAddress, payStub)

  const RegisterFileImage({
    Key? key, 
    required this.imageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: _mediaQuerySize.height * 0.6,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: _constructImage(context),
        ),
      ),
    );
  }

  //Widget que construye el card de imágen de acuerdo a la opcion cargada
  Widget _constructImage(BuildContext context) {

    final _cientsService = Provider.of<ClientsService>(context);

    switch(this.imageType){
      case 'ine':
        if(_cientsService.currentClient.ine! == ''){
          return Image(
            image: AssetImage('assets/no_image.png'),
            fit: BoxFit.cover,
          );
        }
        else if(_cientsService.currentClient.ine!.startsWith('http')) {
          return FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(_cientsService.currentClient.ine!),
            fit: BoxFit.cover,
          );
        }
        else if(fileextension.extension(_cientsService.currentClient.ine!) == '.pdf') {
          return FutureBuilder(
            future: PdfHelper.loadPreviewFromFile(path: _cientsService.currentClient.ine!),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Image(
                  image: AssetImage('assets/no_image.png'),
                  fit: BoxFit.cover,
                );
              }
              return Image.memory(snapshot.data as Uint8List);
            },
          );
        }
        else{
          return Image.file(
            File(_cientsService.currentClient.ine!),
            fit: BoxFit.cover
          );
        }
      case 'ineBack':
        if(_cientsService.currentClient.ineBack == ''){
          return Image(
            image: AssetImage('assets/no_image.png'),
            fit: BoxFit.cover,
          );
        }
        else if(_cientsService.currentClient.ineBack!.startsWith('http')) {
          return FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(_cientsService.currentClient.ineBack!),
            fit: BoxFit.cover,
          );
        }
        else if(fileextension.extension(_cientsService.currentClient.ineBack!) == '.pdf') {
          return FutureBuilder(
            future: PdfHelper.loadPreviewFromFile(path: _cientsService.currentClient.ineBack!),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Image(
                  image: AssetImage('assets/no_image.png'),
                  fit: BoxFit.cover,
                );
              }
              return Image.memory(snapshot.data as Uint8List);
            },
          );
        }
        else{
          return Image.file(
            File(_cientsService.currentClient.ineBack!),
            fit: BoxFit.cover
          );
        }
      case 'selfie':
        if(_cientsService.currentClient.selfie == ''){
          return Image(
            image: AssetImage('assets/no_image.png'),
            fit: BoxFit.cover,
          );
        }
        else if(_cientsService.currentClient.selfie!.startsWith('http')) {
          return FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(_cientsService.currentClient.selfie!),
            fit: BoxFit.cover,
          );
        }
        else{
          return Image.file(
            File(_cientsService.currentClient.selfie!),
            fit: BoxFit.cover
          );
        }
      case 'proofAddress':
        if(_cientsService.currentClient.proofAddress == ''){
          return Image(
            image: AssetImage('assets/no_image.png'),
            fit: BoxFit.cover,
          );
        }
        else if(_cientsService.currentClient.proofAddress!.startsWith('http')) {
          return FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(_cientsService.currentClient.proofAddress!),
            fit: BoxFit.cover,
          );
        }
        else if(fileextension.extension(_cientsService.currentClient.proofAddress!) == '.pdf') {
          return FutureBuilder(
            future: PdfHelper.loadPreviewFromFile(path: _cientsService.currentClient.proofAddress!),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Image(
                  image: AssetImage('assets/no_image.png'),
                  fit: BoxFit.cover,
                );
              }
              return Image.memory(snapshot.data as Uint8List);
            },
          );
        }
        else{
          return Image.file(
            File(_cientsService.currentClient.proofAddress!),
            fit: BoxFit.cover
          );
        }
      case 'payStub':
        if(_cientsService.currentClient.payStub == ''){
          return Image(
            image: AssetImage('assets/no_image.png'),
            fit: BoxFit.cover,
          );
        }
        else if(_cientsService.currentClient.payStub!.startsWith('http')) {
          return FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(_cientsService.currentClient.payStub!),
            fit: BoxFit.cover,
          );
        }
        else if(fileextension.extension(_cientsService.currentClient.payStub!) == '.pdf') {
          return FutureBuilder(
            future: PdfHelper.loadPreviewFromFile(path: _cientsService.currentClient.payStub!),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Image(
                  image: AssetImage('assets/no_image.png'),
                  fit: BoxFit.cover,
                );
              }
              return Image.memory(snapshot.data as Uint8List);
            },
          );
        }
        else{
          return Image.file(
            File(_cientsService.currentClient.payStub!),
            fit: BoxFit.cover
          );
        }
      default:
        return Container();
    }
  }

  //Decoration que añade un borde y sombra a la card de imágen
  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: Offset(0,5)
        )
      ]
    );
  } 
}