import 'package:flutter/material.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:provider/provider.dart';

class AppBarRegister extends StatelessWidget with PreferredSizeWidget {
  const AppBarRegister({
    Key? key,
    required String textStep,
    required double mediaQuerySizeFixedHeightCircles,
    required double textWidth
  }) : _mediaQuerySizeFixedHeightCircles = mediaQuerySizeFixedHeightCircles, _textStep = textStep, _textWidth = textWidth, super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(104);

  final double _mediaQuerySizeFixedHeightCircles;
  final String _textStep;
  final double _textWidth;

  @override
  Widget build(BuildContext context) {
    final _registerForm = Provider.of<RegisterFormProvider>(context);
    return AppBar(
      automaticallyImplyLeading: false, //Quita del appbar la flecha para regresar a pagina anterior
      toolbarHeight: 104,
      elevation: 0,
      title: Container(
        width: double.infinity,
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                _textStep,
                style: TextStyle(
                  fontSize: _textWidth,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(_mediaQuerySizeFixedHeightCircles),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    child: FittedBox(fit: BoxFit.fitWidth, child: Text('1', textAlign: TextAlign.center, style: TextStyle(fontSize: _textWidth))),
                    height: _mediaQuerySizeFixedHeightCircles,
                    width: _mediaQuerySizeFixedHeightCircles,
                    color: _registerForm.stepAppBarCount >= 1 ? Color.fromRGBO(191, 155, 81, 1) : Colors.grey[500]
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(_mediaQuerySizeFixedHeightCircles),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    child: FittedBox(fit: BoxFit.fitWidth, child: Text('2', textAlign: TextAlign.center)),
                    height: _mediaQuerySizeFixedHeightCircles,
                    width: _mediaQuerySizeFixedHeightCircles,
                    color: _registerForm.stepAppBarCount >= 2 ? Color.fromRGBO(191, 155, 81, 1) : Colors.grey[500]
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(_mediaQuerySizeFixedHeightCircles),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    child: FittedBox(fit: BoxFit.fitWidth, child: Text('3', textAlign: TextAlign.center)),
                    height: _mediaQuerySizeFixedHeightCircles,
                    width: _mediaQuerySizeFixedHeightCircles,
                    color: _registerForm.stepAppBarCount >= 3 ? Color.fromRGBO(191, 155, 81, 1) : Colors.grey[500]
                  ),
                )
              ],
            ),
            SizedBox(height: 6)
          ],
        ),
      )
    );
  }
}