import 'package:flutter/material.dart';

import 'package:prestaprofe/src/pages/pages.dart';

Map<String, WidgetBuilder> getAppRoutes(){
  return <String, WidgetBuilder>{
    'checking'  : ( _ ) => CheckAuthPage(),
    'login'     :   (BuildContext context) => LoginPage(),
    'registerStepOne'   : (BuildContext context) => StepOne(),
    'registerStepTwo'   :   (BuildContext context) => StepTwo(),
    'registerStepThree' : (BuildContext context) => StepThree(),
    'registerStepThreeFile' : (BuildContext context) => StepThreeFile(),
    'registerStepFour' : (BuildContext context) => StepFour(),
    'registerStepFive' : (BuildContext context) => StepFive(),
    'registerStepSix' : (BuildContext context) => StepSix(),
    'home'              : (BuildContext context) => HomePage(),
    'myCredits'         : (BuildContext context) => MyCredits(),
    'newCreditStepOne'         : (BuildContext context) => NewCreditStepOne(),
    'newCreditStepTwo'         : (BuildContext context) => NewCreditStepTwo()
  };    
}

