import 'package:elevate_tracking_app/core/custom_widget/custom_dialog.dart';
import 'package:elevate_tracking_app/core/router/route_names.dart';
import 'package:elevate_tracking_app/presentation/apply/view/widgets/apply_body_builder.dart';
import 'package:elevate_tracking_app/presentation/apply/view_model/apply_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ApplyBody extends StatelessWidget {
  const ApplyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ApplyViewModel, ApplyViewModelState>(
      listener: (context, state) {
        if (state.applyFun?.isLoading == true) {
          CustomDialog.loading(context: context);
        } else if (state.applyFun?.data != null) {
          context.pop();
          context.go(RouteNames.applicationApproved);
        } else if (state.applyFun?.errorMessage != null) {
          context.pop();
          CustomDialog.positiveButton(
            context: context,
            cancelable: true,
            title: state.applyFun?.errorMessage,
          );
        }
      },
      child: const ApplyBodyBuilder(),
    );
  }
}
