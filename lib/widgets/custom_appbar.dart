import 'package:flutter/material.dart';

import '../models/pic_list_model.dart';

class CustomAppBar extends StatelessWidget {
  final ListPicResponse pic;

  const CustomAppBar({super.key, required this.pic});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        leading: Hero(
          tag: pic.id!,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        expandedHeight: 400,
        floating: false,
        pinned: true,
        flexibleSpace: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'zoom', arguments: pic);
          },
          child: FlexibleSpaceBar(
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
                  image: pic.downloadUrl != null
                      ? NetworkImage(pic.downloadUrl!)
                      : const AssetImage('assets/images/notfound.png')
                          as ImageProvider<Object>,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/notfound.png');
                  },
                  fit: BoxFit.cover,
                ),
              )),
        ));
  }
}
