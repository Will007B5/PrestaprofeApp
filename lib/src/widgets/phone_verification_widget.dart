import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:prestaprofe/src/models/models.dart';
import 'package:prestaprofe/src/pages/pages.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/services/services.dart';

class PhoneVerification extends StatefulWidget {

  final String inRgisterOrLogedIn;
  final ClientModel currentClient;

  PhoneVerification({
    Key? key, 
    required this.inRgisterOrLogedIn, 
    required this.currentClient
  }) : super(key: key);

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  List<String> _stringCodeSMS = ['', '', '', '']; 
  late List<FocusNode> _focusNodesList;
  late List<Widget> _textFieldsOtpList;

  double _countPercentajeCircularSeconds = 1.0;
  int _countSeconds = 60;
  bool _isRstartPercentajeCircularSeconds = false;
  bool _firstTimerPassed = false;
  Timer? _timerPercentajeCircularSeconds;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNodesList = [FocusNode(), FocusNode(), FocusNode(), FocusNode()];
    _textFieldsOtpList = List.generate(4, (int i) {
      print(i);
      return _textFieldOTP(context, charPosition: i);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timerPercentajeCircularSeconds?.cancel();
    _timerPercentajeCircularSeconds = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _height = _mediaQuerySize.height;
    final _width = _mediaQuerySize.width;

    final _clientsService = Provider.of<ClientsService>(context);

    return SafeArea(
      top: false,
      child: WillPopScope(
        child: Scaffold(
          body: !_clientsService.isSaving ? Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container()),
                Text(this.widget.inRgisterOrLogedIn == 'register' ? '¡Usted ha sido registrado con éxito en nuestro sistema!.\n Como último paso, por favor verifique su teléfono.' : 'Por favor verifique su teléfono.',
                  style: TextStyle(
                    fontSize: _width * 0.043,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  elevation: 7,
                  child: Container(
                    decoration: _containerCardBoxDecoration(),
                    padding: EdgeInsets.symmetric(horizontal: 27, vertical: 17),
                    child: Column(
                      children: [
                        SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _textFieldsOtpList,
                        ),
                        Visibility(
                          visible: !_clientsService.isValidOtp,
                          maintainSize: true, 
                          maintainAnimation: true,
                          maintainState: true,
                          child: Text('CODIGO INCORRECTO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: _width * 0.037, color: Colors.red), textAlign: TextAlign.start)
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  color: Color.fromRGBO(51, 114, 134, 1),
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      !_firstTimerPassed ? 'Enviar código' : 'Reenviar código', 
                      style: TextStyle(
                        fontSize: _width * 0.063,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    ),
                  ),
                  onPressed: (!_clientsService.isSaving && _timerPercentajeCircularSeconds == null)? () async {
                    if((this.widget.currentClient.phone != null || this.widget.currentClient.phone != '') && this.widget.currentClient.phone!.length == 10){
                      print(this.widget.currentClient.phone);
                      final response = await _clientsService.sendSmsToClient(this.widget.currentClient);
                      if(response == 200){
                        _clientsService.isValidOtp = true;
                        _startTimerPercentajeCircularSeconds();
                      }
                    }
                  }: null
                ),
                SizedBox(height: 7),
                Visibility(
                  visible: _firstTimerPassed,
                  child: Text('¿Aún no recibe el código?',
                    style: TextStyle(
                      fontSize: _width * 0.034,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87
                    ),
                  ),
                ),
                SizedBox(height: 10),
                _isRstartPercentajeCircularSeconds ? CircularPercentIndicator(
                  radius: (_width * _height) * 0.000073,
                  animation: true,
                  animateFromLastPercent: true,
                  lineWidth: _width * 0.015,
                  percent: _countSeconds / 60,
                  center: new Text('${_countSeconds}', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: _width * 0.035)),
                  circularStrokeCap: CircularStrokeCap.butt,
                  backgroundColor: Colors.grey,
                  progressColor: Color.fromRGBO(51, 114, 134, 1),
                ) : Container(),
                Expanded(child: Container()),
                GestureDetector(
                  child: Visibility(
                    visible: _firstTimerPassed,
                    child: Text('¿Tiene problemas al confirmar? Presione para realizar la confirmación en otro momento',
                      style: TextStyle(
                        fontSize: _width * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () async {
                    final returnToPage = await showReturningPreviousPage(context, '');
                    if(returnToPage){
                      Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
                    }
                  },
                ),
                // Column(
                //   children: [
                //     SizedBox(height: 10),
                //     Container(
                //       width: double.infinity,
                //       child: MaterialButton(
                //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                //         disabledColor: Colors.grey,
                //         color: Color.fromRGBO(51, 114, 134, 1),
                //         elevation: 0,
                //         child: Text(
                //           _clientsService.isSaving ? 'Cargando...' : 'Aceptar', 
                //           style: TextStyle(
                //             color: Colors.white
                //           )
                //         ),
                //         onPressed: !_clientsService.isSaving ? () async {
                //           // FocusScope.of(context).unfocus(); //Linea para ocultar el teclado
                //           // final response = await _clientsService.verifyCliet(this.widget.currentClient);
                //           // if(response == 200){
                //           //   Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
                //           // }
                //         } : null,
                //       ),
                //     )
                //   ],
                // ),
                SizedBox(height: 5)
              ]
            ),
          ) : LoadingPage(),
        ),
        onWillPop: () async{
          final returnToPage = await showReturningPreviousPage(context, '');
          return returnToPage;
        },
      ),
    );
  }

  BoxDecoration _containerCardBoxDecoration() {
    return BoxDecoration(
      color: Color.fromRGBO(255, 255, 255, 1), 
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Color.fromRGBO(51, 114, 134, 1),
        width: 3,
      )
    );
  }

  Widget _textFieldOTP(BuildContext context, {required int charPosition}){
    final _clientsService = Provider.of<ClientsService>(context, listen: false);
    return Container(
      height: 90,
      child: AspectRatio(
        aspectRatio: 0.6,
        child: RawKeyboardListener( //Widget para detectar teclas presionadas
          focusNode: FocusNode(), //Ocupa un focus
          onKey: (event){
            if(event.runtimeType.toString() == 'RawKeyDownEvent'){ //Este if es por que se repite dos veces este proceso. Este if lo evita
              if (event.logicalKey == LogicalKeyboardKey.backspace) {
                _stringCodeSMS[charPosition] = ''; 
                print(_stringCodeSMS.toString());
                if (charPosition == 0) return;
                _focusNodesList[charPosition].unfocus();
                _focusNodesList[charPosition - 1].requestFocus();
              }
            }
          },
          child: TextField(
            focusNode: _focusNodesList[charPosition],
            onChanged: (value){
              // Checa si el valor en esta posicion está vacio
              // Si lo esta, mueve el focus a una posicion anterior si la hay
              // Remueve el focus
              if (value.isNotEmpty) {
                _focusNodesList[charPosition].unfocus();
                _stringCodeSMS[charPosition] = value; 
                print(_stringCodeSMS.toString());
                _clientsService.debouncerWaitOtpCode(_stringCodeSMS, context, this.widget.currentClient);
              }
              // Va al siguiente focus si lo hay
              if (charPosition + 1 != 4 && value.isNotEmpty){
                FocusScope.of(context).requestFocus(_focusNodesList[charPosition + 1]);
              }
            },
            cursorColor: Color.fromRGBO(51, 114, 134, 1),
            showCursor: false,
            readOnly: false,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counter: Offstage(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Color.fromRGBO(51, 114, 134, 1)),
                borderRadius: BorderRadius.circular(12)
              )
            ),
          ),
        ),
      ),
    );
  }

  void _startTimerPercentajeCircularSeconds(){
    if(this.mounted){
      _isRstartPercentajeCircularSeconds = !_isRstartPercentajeCircularSeconds;
      _timerPercentajeCircularSeconds = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _countSeconds--;
          if(timer.tick == 60){
            _countSeconds--;
            _cancelTimerPercentajeCircularSeconds();
          }
        });
      });
    }
  }

  void _cancelTimerPercentajeCircularSeconds(){
    if(this.mounted){
      _countSeconds = 60;
      _countPercentajeCircularSeconds = 1.0;
      _isRstartPercentajeCircularSeconds = !_isRstartPercentajeCircularSeconds;
      if(!_firstTimerPassed){
        _firstTimerPassed = !_firstTimerPassed;
      }
      _timerPercentajeCircularSeconds?.cancel();
      _timerPercentajeCircularSeconds = null;
    }
  }

  //Dialogo para evitar el cierre de esta pantalla mediante este dialogo
  Future<bool> showReturningPreviousPage(BuildContext context, String inRgisterOrLogedIn) async {
    bool _isTueOrFalse = false;
    await showDialog(
      context: context,
      builder: (context) => WillPopScope(
        child: AlertDialog(
          title: Text('¿Desea confirmar su número telefónico en otro momento?'),
          content: Text('Al aceptar, regresará a la pantalla de inicio y tendrá que esperar hasta que su cuenta sea habilitada para utilizar PrestaprofeApp. \nUna vez habilitada su cuenta tendrá que iniciar sesión para proceder con la confirmación de su teléfono. \n¿Desea continuar?'),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: (){
                _isTueOrFalse = false;
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Si'),
              onPressed: (){
                _isTueOrFalse = true;
                Navigator.pop(context);
              },
            ),
          ],
        ),
        onWillPop: () async {
          return false;
        },
      ),
      barrierDismissible: false
    );
    print(_isTueOrFalse);
    return _isTueOrFalse;
  }
}