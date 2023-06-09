import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picsum/bloc/app/app_bloc.dart';


class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    final appBloc=BlocProvider.of<AppBloc>(context);
    return Stack(
      children: [
        Container(
          decoration: appBloc.state.isThemeLight? boxDecoration() :boxDecorationDark(),
        ),
        Positioned(
         left: -200,
         top:-335,
               child: Transform.scale(
                scale: 0.4,
                child: Image.asset('assets/images/logo.png')),
        ),

      ],
    );
  }

  BoxDecoration boxDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
       stops: [0.2,0.8],
      colors: [
        Color(0xFFCAF0F8),
        Color(0xFFADE8F4)
      ]
    )
  );

  
  BoxDecoration boxDecorationDark() => const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
       stops: [0.2,0.8],
      colors: [
        Color(0xFF012A4A),
        Color(0xFF013A63)
      ]
    )
  );
}