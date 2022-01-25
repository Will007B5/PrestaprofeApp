import 'package:flutter/material.dart';

class AppBarRegister extends StatelessWidget with PreferredSizeWidget {
  const AppBarRegister({
    Key? key,
    required String textStep,
    required double mediaQuerySizeFixedHeightCircles,
  }) : _mediaQuerySizeFixedHeightCircles = mediaQuerySizeFixedHeightCircles, _textStep = textStep, super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(120);

  final double _mediaQuerySizeFixedHeightCircles;
  final String _textStep;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, //Quita del appbar la flecha para regresar a pagina anterior
      toolbarHeight: 120,
      elevation: 0,
      title: Container(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              _textStep,
              style: TextStyle(
                fontSize: 22.5,
                fontWeight: FontWeight.bold

              )
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(_mediaQuerySizeFixedHeightCircles),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    child: Text('1', textAlign: TextAlign.center),
                    height: _mediaQuerySizeFixedHeightCircles,
                    width: _mediaQuerySizeFixedHeightCircles,
                    color: Colors.green[300]
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(_mediaQuerySizeFixedHeightCircles),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    child: Text('2', textAlign: TextAlign.center),
                    height: _mediaQuerySizeFixedHeightCircles,
                    width: _mediaQuerySizeFixedHeightCircles,
                    color: Colors.grey[500]
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(_mediaQuerySizeFixedHeightCircles),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    child: Text('3', textAlign: TextAlign.center),
                    height: _mediaQuerySizeFixedHeightCircles,
                    width: _mediaQuerySizeFixedHeightCircles,
                    color: Colors.grey[500]
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