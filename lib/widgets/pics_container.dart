import 'package:flutter/material.dart';
import '../bloc/app/app_bloc.dart';
import '../models/pic_list_model.dart';

class PicsContainer extends StatelessWidget {
  final AppState appState;
  final BuildContext context;
  final int index;
  final ListPicResponse pic;

  const PicsContainer(
      {super.key,
      required this.appState,
      required this.context,
      required this.index,
      required this.pic});

  @override
  Widget build(BuildContext context) {
    const Color colorDark = Color(0xFF2A6F97);
    const Color colorLight = Color(0xFFA9D6E5);

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: appState.isThemeLight ? colorDark : colorLight, width: 2),
        borderRadius: BorderRadius.circular(20),
        color: appState.isThemeLight ? colorLight : colorDark,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: const AssetImage('assets/images/loading.gif'),
                  image: pic.downloadUrl != null
                      ? NetworkImage(pic.downloadUrl!)
                      : const AssetImage('assets/images/notfound.png')
                          as ImageProvider<Object>,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/notfound.png');
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  pic.author ?? 'Undefined author',
                  style: TextStyle(
                    color: appState.isThemeLight ? colorDark : colorLight,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
