import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picsum/widgets/widgets.dart';

import '../bloc/app/app_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = BlocProvider.of<AppBloc>(context);
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text('PICSUM'),
              backgroundColor: appState.state.isThemeLight
                  ? const Color(0xFFA9D6E5)
                  : const Color(0xFF012A4A),
              centerTitle: true,
            ),
            body: Background(),
            drawer: CustomDrawer());
      },
    );
  }
}
