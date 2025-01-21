import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexplore/auth/screen/accountInfo.dart';
import 'package:nexplore/auth/screen/morePage.dart';
import 'package:nexplore/core/themes/TextStyles.dart';
import 'package:nexplore/features/movie/ui/widgets/now_showing.dart';
import 'package:nexplore/gen/assets.gen.dart';

import '../widgets/popular_movies.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});
  static String id = 'MovieScreen';
  @override
  Widget build(BuildContext context) {
    String userEmail = FirebaseAuth.instance.currentUser!.email!;

    return Scaffold(
      appBar: AppBar(
        title: Text('NexPlore', style: TextStyles.title),
        centerTitle: true,
        leading: SizedBox(
          width: 2,
          height: 2,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AccountInformation.id,
                  arguments: userEmail);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Assets.images.menu.svg(),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, MorePage.id);
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            NowShowing(),
            PopularMovies(),
          ],
        ),
      )),
    );
  }
}
