import 'package:flutter/material.dart';

import 'package:prestaprofe/src/pages/home_page.dart';
import 'package:prestaprofe/src/pages/mycredits_page.dart';
import 'package:prestaprofe/src/pages/newcredit_page.dart';
import 'package:prestaprofe/src/pages/register_stepthree_page.dart';
import 'package:prestaprofe/src/pages/register_steptwo_page.dart';
import 'package:prestaprofe/src/pages/register_stepone_page.dart';
import 'package:prestaprofe/src/pages/login_page.dart';

Map<String, WidgetBuilder> getAppRoutes(){
  return <String, WidgetBuilder>{
    '/'     :   (BuildContext context) => LoginPage(),
    'registerStepOne'   : (BuildContext context) => StepOne(),
    'registerStepTwo'   :   (BuildContext context) => StepTwo(),
    'registerStepThree' : (BuildContext context) => StepThree(),
    'home'              : (BuildContext context) => HomePage(),
    'myCredits'         : (BuildContext context) => MyCredits(),
    'newCredit'         : (BuildContext context) => NewCredit()
  };    
}

