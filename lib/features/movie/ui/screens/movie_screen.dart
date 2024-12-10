import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexplore/core/routes/routres.dart';
import 'package:nexplore/core/themes/TextStyles.dart';
import 'package:nexplore/features/movie/ui/widgets/app_bar.dart';
import 'package:nexplore/features/movie/ui/widgets/now_showing.dart';
import 'package:nexplore/gen/assets.gen.dart';
import 'package:nexplore/util/extensions/context_extension.dart';

import '../widgets/popular_movies.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

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
              context.navigateWithArgs(Routes.AccountInformation, userEmail);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Assets.images.menu.svg(),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.navigateTo(Routes.MorePage);
              },
              icon: Icon(Icons.more_horiz))
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
