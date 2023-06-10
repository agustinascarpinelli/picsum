import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picsum/models/pic_list_model.dart';
import 'package:picsum/widgets/widgets.dart';

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
                const Background(),
                CustomScrollView(
                  slivers: [
                    _CustomAppBar(pic: pic),
                    SliverList(
                      delegate: SliverChildListDelegate([
    _details(pic: pic)
                      ])
                      )
                
                  ],
                )
              ],
            ));
      },
    );
  }
}

class _details extends StatelessWidget {
  const _details({
    super.key,
    required this.pic,
  });

  final ListPicResponse pic;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                const Text('Author:'),
                Text(pic.author!)
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Text('Height:'),
            Text(pic.height!.toString())
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            const Text('Width:'),
            Text(pic.width!.toString())
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [const Text('Url:'), Text(pic.url!)],
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            const Text('Dowload url:'),
            Text(pic.downloadUrl!)
          ],
        ),
      ],
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final ListPicResponse pic;

  const _CustomAppBar({super.key, required this.pic});
  @override
  Widget build(BuildContext context) {
    /* Es un appBar que tiene un comportamiento cuando se hace scroll */
    return SliverAppBar(
        leading: Hero(
          tag: pic.id!,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        expandedHeight: MediaQuery.of(context).size.height/3,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: const EdgeInsets.all(0),
            title: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              alignment: Alignment.bottomCenter,
              color: Colors.black12,
            ),
            background: Hero(
              tag: pic.id!,
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/loading.gif'),
                image: NetworkImage(pic.downloadUrl!),
                fit: BoxFit.cover,
              ),
            )));
  }
}
