import 'package:flutter/material.dart';

class AppBarRegister extends StatelessWidget with PreferredSizeWidget {
  const AppBarRegister({
    Key? key,
    required double mediaQuerySizeFixedHeightCircles,
  }) : _mediaQuerySizeFixedHeightCircles = mediaQuerySizeFixedHeightCircles, super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(120);

  final double _mediaQuerySizeFixedHeightCircles;

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
              'REGISTRO', 
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold
              )
            ),
            SizedBox(height: 5),
            Text(
              'Completa el siguiente formulario',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold

              )
            ),
            SizedBox(height: 5),
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
                    color: Colors.green
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
                ),
              ],
            ),
            SizedBox(height: 6)
          ],
        ),
      )
    );
  }
}