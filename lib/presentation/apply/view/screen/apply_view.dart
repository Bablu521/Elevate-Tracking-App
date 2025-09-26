import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/core/di/di.dart';
import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/apply/view/widgets/apply_body.dart';
import 'package:elevate_tracking_app/presentation/apply/view_model/apply_event.dart';
import 'package:elevate_tracking_app/presentation/apply/view_model/apply_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ApplyView extends StatelessWidget {
  const ApplyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          key: const Key(WidgetsKeys.kApplyScreenLabel),
          AppLocalizations.of(context).apply,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          onTap: () {
            context.go(RouteNames.login);
          },
          child: const Icon(
            key: Key(WidgetsKeys.kApplyScreenIconArrowBack),
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            getIt.get<ApplyViewModel>()..doIntent(ApplyEventGetAllData()),
        child: const ApplyBody(),
      ),
    );
  }
}
