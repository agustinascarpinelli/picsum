import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picsum/models/pic_list_model.dart';
import 'package:picsum/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/app/app_bloc.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pic = ModalRoute.of(context)!.settings.arguments as ListPicResponse;
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Scaffold(
            endDrawer: const CustomDrawer(),
            body: Stack(
              children: [
                const Background(
                  logo: false,
                ),
                CustomScrollView(
                  slivers: [
                    CustomAppBar(pic: pic),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      _Details(
                        pic: pic,
                        isThemeLight: state.isThemeLight,
                      )
                    ]))
                  ],
                )
              ],
            ));
      },
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({
    super.key,
    required this.pic,
    required this.isThemeLight,
  });

  final ListPicResponse pic;
  final bool isThemeLight;

  @override
  Widget build(BuildContext context) {
    const Color colorLight = Color(0xFFA9D6E5);
    const Color colorDark = Color(0xFF012A4A);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10, 50, 10, 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Author: ',
                  style: TextStyle(
                    fontSize: 25,
                    decoration: TextDecoration.underline,
                    color: isThemeLight ? colorDark : colorLight,
                  )),
              Text(pic.author!,
                  style: TextStyle(
                    fontSize: 25,
                    decoration: TextDecoration.underline,
                    color: isThemeLight ? colorDark : colorLight,
                  ))
            ],
          ),
        ),
        _RowDetail(
            title: 'Height: ',
            subtitle: pic.height.toString(),
            color: isThemeLight ? colorDark : colorLight),
        const SizedBox(
          height: 50,
        ),
        _RowDetail(
            title: 'Width: ',
            subtitle: pic.width.toString(),
            color: isThemeLight ? colorDark : colorLight),
        const SizedBox(
          height: 50,
        ),
        _RowDetail(
            title: 'Url: ',
            subtitle: pic.url!,
            icon: true,
            url:pic.url!,
            color: isThemeLight ? colorDark : colorLight),
        const SizedBox(
          height: 50,
        ),
        Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: _RowDetail(
                title: 'Download url: ',
                subtitle: pic.downloadUrl!,
                color: isThemeLight ? colorDark : colorLight))
      ],
    );
  }
}

class _RowDetail extends StatelessWidget {
  const _RowDetail({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    this.icon = false, this.url,
  });

  final String title;
  final String subtitle;
  final Color color;
  final bool? icon;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: icon==true ? MainAxisAlignment.spaceBetween: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
              title,
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: color),
            )),
            Expanded(
                child: Text(subtitle,
                    style: TextStyle(fontSize: 15, color: color))),
            if (icon == true)
              IconButton(
                icon: const Icon(Icons.open_in_new),
                onPressed: () async {
              final uri = Uri.parse(url!);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              } else {
                AlertDialog(title: Text('No se pudo abrir el enlace $url'));
              }
                },
              )
          ],
        ),
      ),
    );
  }
}
