import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/di.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewModel homeViewModel;

  @override
  void initState() {
    super.initState();
    homeViewModel = getIt.get<HomeViewModel>();
  }

  @override
  void dispose() {
    homeViewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context).floweryRider,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.mainColor,
            fontWeight: FontWeight.w400,
            fontFamily: ConstKeys.iMFeellEnglishFont,
          ),
        ),
      ],
    );
  }
}
