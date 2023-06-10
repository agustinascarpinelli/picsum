import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picsum/bloc/pics/pics_bloc.dart';
import 'package:picsum/models/pic_list_model.dart';
import 'package:picsum/widgets/widgets.dart';

import '../bloc/app/app_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PicsBloc picsBloc;
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int pageNumber = 2;

  @override
  void initState() {
    picsBloc = BlocProvider.of<PicsBloc>(context);
    picsBloc.add(OnGetPhotos(1));
    super.initState();

    scrollController.addListener(() {
      if ((scrollController.position.pixels + 500) >=
          (scrollController.position.maxScrollExtent)) {
        fetchData();
      }
    });
  }

  Future fetchData() async {
    if (isLoading) return;

    isLoading = true;
    setState(() {});

    await Future.delayed(const Duration(seconds: 3));

    loadMorePics();

    isLoading = false;
    setState(() {});

    if ((scrollController.position.pixels + 500) >=
        (scrollController.position.maxScrollExtent)) {
      return;
    } else {
      scrollController.animateTo(scrollController.position.pixels + 120,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn);
    }
  }

  void loadMorePics() {
    picsBloc.add(OnGetPhotos(pageNumber));
    pageNumber++;
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    loadMorePics();
  }

  @override
  Widget build(BuildContext context) {
    final appState = BlocProvider.of<AppBloc>(context);
    final size = MediaQuery.of(context).size;
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('PICSUM'),
          backgroundColor: appState.state.isThemeLight
              ? const Color(0xFFA9D6E5)
              : const Color(0xFF012A4A),
          centerTitle: true,
        ),
        drawer: const CustomDrawer(),
        body: Stack(
          children: [
            const Background(),
            RefreshIndicator(
              color: const Color(0xFFA9D6E5),
              onRefresh: onRefresh,
              child: BlocBuilder<PicsBloc, PicsState>(
                builder: (context, state) {
                  if (state.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.error != null) {
                    return Center(
                      child: Text(state.error!),
                    );
                  } else if (state.pics.isNotEmpty) {
                    return ListView.builder(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.pics.length,
                      itemBuilder: (BuildContext context, int index) {
                        final pic = state.pics[index];
                        return GestureDetector(
                          onTap: () {
                           Navigator.pushNamed(context, 'details',
                        arguments: pic);
                          },
                          child: Hero(
                            tag: pic.id!,
                            child: _picsContainer(appState, context, index, pic)),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
            if (isLoading)
              Positioned(
                bottom: 40,
                left: size.width * 0.5 - 30,
                child: const LoadingIcon(),
              ),
          ],
        ),
      );
    });
  }
}

Container _picsContainer(
    AppBloc appState, BuildContext context, int index, ListPicResponse pic) {
  return Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(
          color: appState.state.isThemeLight
              ? const Color(0xFF2A6F97)
              : const Color(0xFFA9D6E5),
          width: 2),
      borderRadius: BorderRadius.circular(20),
      color: appState.state.isThemeLight
          ? const Color(0xFF90E0EF)
          : const Color(0xFF023E8A),
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
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                pic.author ?? 'Undefined author',
                style: TextStyle(
                  color: appState.state.isThemeLight
                      ? const Color(0xFF012A4A)
                      : const Color(0xFFA9D6E5),
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

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 60,
      width: 60,
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: const CircularProgressIndicator(
        color: Color(0xFFA9D6E5),
      ),
    );
  }
}
