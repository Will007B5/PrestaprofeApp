import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/helpers/helpers.dart';
import 'package:prestaprofe/src/models/models.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/ui/input_decorations.dart';

class RegisterDebitClabe extends StatelessWidget {

  //Hay que usar controllers ya que como este es un StatelessWidget
  //Entonces al hacer el if de card/clabe, si se cambia la ui, la validación sigue ahi
  //Ademas de que hay que tener todos los datos de manera indepentientes en controllers
  TextEditingController _textfieldClabeController = new TextEditingController(); //Controlador que lleva la data del numero de clabe
  TextEditingController _textfieldCardNumberController = new TextEditingController(); //Controlador que lleva la data del numero de la tarjeta
  TextEditingController _textfieldYearController = new TextEditingController(); //Controlador que lleva la data del año de la tarjeta
  TextEditingController _textfieldMonthController = new TextEditingController(); //Controlador que lleva la data del mes de la tarjeta
  int _textfieldClabeControllerLength = 0;

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _height = _mediaQuerySize.height;
    final _width = _mediaQuerySize.width;
    final _objectSize = _height * _width;

    final _authService = Provider.of<AuthService>(context);
    final _cardsService = Provider.of<CardsService>(context);
    final _cardFormProvider = Provider.of<CardFormProvider>(context);

    _textfieldClabeController.addListener(() async {
      if ((_textfieldClabeController.text.length - _textfieldClabeControllerLength).abs() > 1 ){
        ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);
        String copiedtext = cdata?.text ?? '';
        _textfieldClabeController.text = copiedtext.replaceAll(' ', '');
        print('DESPUES COPy: ${_textfieldClabeController.text}');
      }
      _textfieldClabeControllerLength = _textfieldClabeController.text.length;
    });

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(elevation: 0),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: _cardFormProvider.formRegisterClabeCard,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 15),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: _objectSize * 0.00038,
                              backgroundColor: Color.fromRGBO(51, 114, 134, 1),
                              child: CircleAvatar(
                                backgroundColor: Color.fromRGBO(51, 114, 134, 1),
                                radius:  _objectSize * 0.00036,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(130),
                                  child: Image(
                                    image: AssetImage('assets/creditcard.png'),
                                    fit: BoxFit.fill,
                                  ),
                                )
                              ),
                            ),
                            SizedBox(height: 15),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              color: Color.fromRGBO(255, 255, 255, 0.94),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 35, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 1), 
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color.fromRGBO(51, 114, 134, 1),
                                    width: 2,
                                  )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('QUIERO AGREGAR   ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: _width * 0.037, color: Color.fromRGBO(51, 114, 134, 1)), textAlign: TextAlign.center),
                                        GestureDetector(
                                          child: Text(_cardFormProvider.cardOrClabe == 'card' ? 'TARJETA' : 'CLABE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: _width * 0.037, color: Color.fromRGBO(51, 114, 134, 1), letterSpacing: 5, decoration: TextDecoration.underline), textAlign: TextAlign.center),
                                          onTap: (){
                                            switch(_cardFormProvider.cardOrClabe){
                                              case 'card':
                                                _cardFormProvider.formRegisterClabeCard.currentState?.reset();
                                                _cardFormProvider.cardOrClabe = 'clabe';
                                                break;
                                              case 'clabe':
                                                _cardFormProvider.formRegisterClabeCard.currentState?.reset();
                                                _cardFormProvider.cardOrClabe = 'card';
                                                break;
                                            }
                                          },
                                        ),
                                        Icon(Icons.arrow_drop_down, color: Color.fromRGBO(51, 114, 134, 1), size: 19)
                                      ],
                                    ),
                                    SizedBox(height: 25),
                                    _cardFormProvider.cardOrClabe == 'card' ? 
                                    //Si es tarjeta, muestra campos de tarjeta
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                        style: TextStyle(fontSize: _width * 0.04),
                                        decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Número de tarjeta', prefixIcon: Icons.account_circle_rounded, height: _height, textWidth: _width),
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        enabled: !_cardsService.isSaving,
                                        autocorrect: false,
                                        keyboardType: TextInputType.number,
                                        controller: _textfieldCardNumberController,
                                        ),
                                        SizedBox(height: 15),
                                        Text('EXPIRA EN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: _width * 0.037, color: Color.fromRGBO(51, 114, 134, 1)), textAlign: TextAlign.start),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 7),
                                                child: TextFormField(
                                                style: TextStyle(fontSize: _width * 0.04),
                                                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Mes (MM)', prefixIcon: Icons.account_circle_rounded, height: _height, textWidth: _width),
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  enabled: !_cardsService.isSaving,
                                                  autocorrect: false,
                                                  keyboardType: TextInputType.number,
                                                  controller: _textfieldMonthController,
                                                  inputFormatters: [
                                                      LengthLimitingTextInputFormatter(2),
                                                      FilteringTextInputFormatter.allow(RegexHelper.monthAndYearNumbersOnly)
                                                  ],
                                                  validator: (value) {
                                                    return (value?.length != 2 ) ? 'Debe llenar este campo' : RegexHelper.monthTwoDigitsRule.hasMatch(value ?? '') ? null : 'Mes no válido';
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                style: TextStyle(fontSize: _width * 0.04),
                                                decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Año (AA)', prefixIcon: Icons.account_circle_rounded, height: _height, textWidth: _width),
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                enabled: !_cardsService.isSaving,
                                                autocorrect: false,
                                                keyboardType: TextInputType.number,
                                                controller: _textfieldYearController,
                                                inputFormatters: [
                                                    LengthLimitingTextInputFormatter(2),
                                                    FilteringTextInputFormatter.allow(RegexHelper.monthAndYearNumbersOnly)
                                                ],
                                                validator: (value) {
                                                  return (value?.length != 2 ) ? 'Debe llenar este campo' : RegexHelper.yearTwoDigitsRule.hasMatch(value ?? '') ? null : 'Año no válido';
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ) :
                                    //Si es clabe, muestra campo de clabe
                                    Column(
                                      children: [
                                        TextFormField(
                                        style: TextStyle(fontSize: _width * 0.04),
                                        decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Cuenta CLABE', prefixIcon: Icons.account_circle_rounded, height: _height, textWidth: _width),
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        enabled: !_cardsService.isSaving,
                                        autocorrect: false,
                                        keyboardType: TextInputType.number,
                                        controller: _textfieldClabeController,
                                        inputFormatters: [
                                            LengthLimitingTextInputFormatter(18),
                                            FilteringTextInputFormatter.allow(RegexHelper.clabe)
                                        ],
                                        validator: (value) {
                                          return (value?.length == 18) && ClabeHelper.isValidClabe(completeClabe: value ?? '') ? null : 'Ingrese cuenta CLABE válida';
                                        },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                disabledColor: Colors.grey,
                                color: Color.fromRGBO(51, 114, 134, 1),
                                elevation: 0,
                                child: Text(
                                  _cardsService.isSaving ? 'Espere...' : 'Continuar', 
                                  style: TextStyle(
                                    color: Colors.white
                                  )
                                ),
                                onPressed: !_cardsService.isSaving ? () async {
                                  FocusScope.of(context).unfocus(); //Linea para ocultar el teclado
                                  print(_textfieldCardNumberController.text);
                                  print(_textfieldClabeController.text);
                                  if(!_cardFormProvider.isValidFormRegisterClabeCard()) return;
                                  
                                  late CardModel _newCard;

                                  if(_cardFormProvider.cardOrClabe == 'card'){
                                    _newCard = new CardModel(
                                      userId: _authService.currentClient.id!,
                                      cardNumber: _textfieldCardNumberController.text,
                                      expiredDate: '${_textfieldYearController.text}/${_textfieldMonthController.text}'
                                    );
                                  }
                                  else if(_cardFormProvider.cardOrClabe == 'clabe'){
                                    _newCard = new CardModel(
                                      userId: _authService.currentClient.id!,
                                      clabe: _textfieldClabeController.text
                                    );
                                  }

                                  final response = await _cardsService.registerCardClabe(_newCard);

                                  if(response == 200){
                                    //Del stack de rutas reemplaza y dirige hacia ruta 'newCreditStepOne'
                                    //Si con el boton de navegacion back es presionado, ahora regresa al home
                                    Navigator.of(context).pushReplacementNamed('newCreditStepOne');
                                  }
                                } : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}