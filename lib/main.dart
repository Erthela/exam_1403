import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:exam_1403/repo/photo_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/photo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  final _controller = TextEditingController(text: 'Test');

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _value = 'default';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Экзамен 14.03', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 327,
                height: 177,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return CachedNetworkImage(
                      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${index + 1}.png',
                      imageBuilder: (context, imageProvider) => Container(
                        color: Colors.purple,
                        child: Center(
                          child: Image(
                            image: imageProvider,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 10,
                  itemHeight: 100,
                  itemWidth: 100,
                  viewportFraction: 0.8,
                  scale: 0.9,
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Photo>>(
              future: PhotoRepository.fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.requireData.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => SizedBox(
                          width: 80,
                          height: 80,
                          child: Image(
                            image: imageProvider,
                          ),
                        ),
                        imageUrl: snapshot.requireData[index].url!,
                        placeholder: (_, __) => const SizedBox(
                          width: 80,
                          height: 80,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      title: Text(
                        snapshot.requireData[index].title!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        '${snapshot.requireData[index].id} | ${snapshot.requireData[index].albumId}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }
}
