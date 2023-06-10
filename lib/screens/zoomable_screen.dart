import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';

import '../bloc/app/app_bloc.dart';
import '../models/pic_list_model.dart';

class ZoomableScreen extends StatelessWidget {
  const ZoomableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pic = ModalRoute.of(context)!.settings.arguments as ListPicResponse;
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Stack(
          children: [
            Center(
              child: Hero(
                tag: pic.id!,
                child: PhotoView(imageProvider: NetworkImage(pic.downloadUrl!)),
              ),
            )
          ],
        ),
      );
    });
  }
}
