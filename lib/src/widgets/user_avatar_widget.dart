import 'package:flutter/material.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/ui/custom_uis.dart';

class UserAvatar extends StatelessWidget {
  final Size mediaQuerySize;
  final double height;
  final double width;
  final String viewedFrom;

  const UserAvatar({
    Key? key,
    required this.mediaQuerySize,
    required this.height,
    required this.width,
    required this.viewedFrom
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _authService = Provider.of<AuthService>(context);

    final TextStyle _helloTextStyle = TextStyle(
      color: PrestaprofeTheme.whiteColorText,
      fontWeight: FontWeight.bold,
      fontSize: this.width * 0.043
    );

    final TextStyle _nameTextStyle = TextStyle(
      color: PrestaprofeTheme.goldenClientName,
      fontWeight: FontWeight.bold,
      fontSize: this.width * 0.0587
    );

    final TextStyle _emailTextStyle = TextStyle(
      color: PrestaprofeTheme.whiteColorText, 
      fontWeight: FontWeight.bold,
      fontSize: this.width * 0.0388
    );

    final String _clientName = viewedFrom == 'dashboard' ? '${_authService.currentClient.name.toUpperCase()}' : '${_authService.currentClient.name.toUpperCase()} ${_authService.currentClient.lastName.toUpperCase()}';

    final double _avatarSizeRadius = viewedFrom == 'dashboard' ? (this.height * this.width) * 0.00026 : (this.height * this.width) * 0.0002;

    final List<Color> _colors = PrestaprofeTheme.avatarGoldenRingColorList;

    return Container(
      child: Column(
        children: [
          OutlineGradientButton(
            gradient: SweepGradient(
              colors: _colors,
              center: Alignment(0.1, 0.0),
            ),
            strokeWidth: 10.7,
            radius: Radius.circular(130),
            backgroundColor: PrestaprofeTheme.strokeSweepGradientRingColor,
            child: CircleAvatar(
              backgroundColor: PrestaprofeTheme.strokeCircleAvatarRingColor,
              radius: _avatarSizeRadius,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(130),
                child: Image(
                  image: AssetImage('assets/hombrelogouser.png'),
                  fit: BoxFit.cover,
                ),
              )
            ),
          ),
          SizedBox(height: 8),
          Column(
            children: [
              viewedFrom == 'dashboard'
              ? Text('HOLA,', overflow: TextOverflow.ellipsis, maxLines: 2, textAlign: TextAlign.center, style: _helloTextStyle)
              : Container(),
              SizedBox(height: 2),
              Text(_clientName, overflow: TextOverflow.ellipsis, maxLines: viewedFrom == 'dashboard' ? 1 : 2, textAlign: TextAlign.center, style: _nameTextStyle),
              viewedFrom == 'drawermenu'
              ? Text('${_authService.currentClient.email}', overflow: TextOverflow.ellipsis, maxLines: 2, textAlign: TextAlign.center, style: _emailTextStyle)
              : Container(),
            ],
          ),
        ],
      ),
    );
  }

}