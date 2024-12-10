import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexplore/auth/screen/accountInfo.dart';
import 'package:nexplore/core/themes/TextStyles.dart';

import '../../../../gen/assets.gen.dart';

class MovieAppBar extends StatelessWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
        width: double.infinity,
        height: 60.h,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AccountInformation.id,
              );
            },
            child: Assets.images.menu.svg(),
          ),
          const Spacer(),
          Text('NexPlore', style: TextStyles.title),
          const Spacer(),
        ]));
  }
}
