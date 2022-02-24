import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/helpers/helpers.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class MyCredits extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarHome(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: _constructNewCreditBody(context),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }

  Widget _constructNewCreditBody(BuildContext context){

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _authService = Provider.of<AuthService>(context);
    final _loansService = Provider.of<LoansService>(context);
    final _height = _mediaQuerySize.height - 30;
    final _width = _mediaQuerySize.width - 30;
    final _textWidth = _width;
    final _objectSize = _height * _width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(height: 10),
              Text('${_authService.currentClient.name}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.085, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              SizedBox(height: 5),
              Icon(Icons.info, size: _objectSize * 0.00024, color: Colors.green[300]),
              SizedBox(height: 5),
              Text('ACTUALMENTE CUENTAS CON EL SIGUIENTE PRÉSTAMO', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.042, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              SizedBox(height: 50),
              Text('\$${_loansService.loans.last.amount.toString()}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.085, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: _width * 0.4,
                    child: Text('DEBES LIQUIDAR ANTES DE: ', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.044, fontWeight: FontWeight.bold))
                  ),
                  Container(
                    width: _width * 0.6,
                    //child: Text('${_loansService.loans.last.expiredDate.toString()}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1),fontSize: _textWidth * 0.055, fontWeight: FontWeight.bold), textAlign: TextAlign.end)
                  ),
                ],
              ),
            ]
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: _width * 0.4,
                    child: Text('REFERENCIA: ', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.044, fontWeight: FontWeight.bold))
                  ),
                  Container(
                    width: _width * 0.6,
                    child: Text('${_loansService.loans.last.paymentReference != null ? _loansService.loans.last.paymentReference.toString() : ''}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1),fontSize: _textWidth * 0.055, fontWeight: FontWeight.bold), textAlign: TextAlign.end)
                  ),
                ],
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
                    'Generar referencia', 
                    style: TextStyle(
                      color: Colors.white
                    )
                  ),
                  onPressed: () async{
                    // print(_loansService.loans.last.amount);
                    // final r = double.parse(_loansService.loans.last.amount) * 100;
                    // String amountTrued = '';
                    // if (r.toString().contains('.')) {
                    //   amountTrued = r.toString().substring(0, r.toString().indexOf('.'));
                    // }
                    // else{
                    //   amountTrued = r.toString();
                    // }
                    // DateTime fecha = _loansService.loans.last.expiredDate!;
                    // int dia = fecha.day;
                    // int mes = fecha.month;
                    // int an = fecha.year;
                    // String completeDate = '';
                    // if(mes > 9){
                    //   completeDate = dia.toString() + mes.toString() + an.toString().substring(2,4);
                    // }
                    // else{
                    //   completeDate = dia.toString() + '0' + mes.toString() + an.toString().substring(2,4);
                    // }
                    print(Reference35Generator.makeReference(positions: _authService.currentClient.id.toString()+_authService.currentClient.curp!.substring(0,4)));
                    final reference = Reference35Generator.makeReference(positions: _authService.currentClient.id.toString()+_authService.currentClient.curp!.substring(0,4));
                    await _loansService.updateReference(reference, _loansService.loans.last);
                    //Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}