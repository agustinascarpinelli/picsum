import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picsum/bloc/pics/pics_bloc.dart';
import 'package:picsum/screens/screens.dart';
import 'package:provider/provider.dart';

import 'bloc/app/app_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => AppBloc()),
        BlocProvider(create: (_) => PicsBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          textTheme: GoogleFonts.aBeeZeeTextTheme(
              const TextTheme() // Establecer cualquier estilo de texto adicional aquí
              ),
        ),
        initialRoute: 'login',
        routes: {
          'login': (_) => const LoginScreen(),
          'home': (_) => const HomeScreen(),
          'details': (_) => const DetailsScreen(),
          'zoom': (_) => const ZoomableScreen()
        },
      ),
    );
  }
}
