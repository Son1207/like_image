import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:like_image/providers/item_provider.dart';
import 'package:like_image/widget/body_swiper.dart';

void main(List<String> args) {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ItemProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

enum fillterOption { all, favorite }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ItemProvider>(context, listen: false).readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Images'),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  if (value == fillterOption.all) {
                    isFavorite = false;
                  } else {
                    isFavorite = true;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: fillterOption.all,
                  child: Text('Show All'),
                ),
                const PopupMenuItem(
                  value: fillterOption.favorite,
                  child: Text('Favorite'),
                ),
              ],
            ),
          ],
          leading: Padding(
            padding: const EdgeInsets.all(12),
            child: Consumer<ItemProvider>(
              builder: (context, item, child) {
                return badge.Badge(
                  badgeContent: Text(
                    item.countItemFavorite.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: const Icon(Icons.favorite),
                );
              },
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.red, Colors.yellow],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
          ),
        ),
        body: SwipeBody(
          isFavorite: isFavorite,
        ));
  }
}
