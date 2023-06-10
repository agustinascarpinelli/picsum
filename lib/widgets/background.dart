import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picsum/bloc/app/app_bloc.dart';

class Background extends StatelessWidget {
  final bool? logo;
  const Background({Key? key, this.logo = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              decoration: boxDecoration(state.isThemeLight),
            ),
            if (logo == true)
              Positioned(
                left: -200,
                top: -335,
                child: Transform.scale(
                  scale: 0.4,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
          ],
        );
      },
    );
  }

  BoxDecoration boxDecoration(bool isThemeLight) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0.2, 0.8],
        colors: isThemeLight
            ? const [Color(0xFFCAF0F8), Color(0xFFADE8F4)]
            : const [Color(0xFF012A4A), Color(0xFF013A63)],
      ),
    );
  }
}
