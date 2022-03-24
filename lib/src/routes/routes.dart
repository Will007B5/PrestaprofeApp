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
    'registerDebitClabe' : (BuildContext context) => RegisterDebitClabe(),
    'home'              : (BuildContext context) => HomePage(),
    'dashboard'              : (BuildContext context) => DashboardPage(),
    'newCreditStepOne'         : (BuildContext context) => NewCreditStepOne(),
    'myCredits'         : (BuildContext context) => MyCredits(),
    'help'         : (BuildContext context) => HelpPage(),
    'frecuentQuestions'         : (BuildContext context) => FrecuentQuestionsPage(),
  };    
}

