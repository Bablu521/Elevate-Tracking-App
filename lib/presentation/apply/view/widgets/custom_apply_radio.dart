import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:elevate_tracking_app/core/constants/const_keys.dart';
import 'package:elevate_tracking_app/core/constants/widgets_keys.dart';
import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:elevate_tracking_app/presentation/apply/view_model/apply_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomApplyRadio extends StatelessWidget {
  const CustomApplyRadio({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<ApplyViewModel>(context);
    return Row(
      children: [
        Text(
          key: const Key(WidgetsKeys.kApplyScreenTextGender),
          local.gender,
          style: theme.textTheme.headlineMedium!.copyWith(
            color: AppColors.gray,
          ),
        ),
        ValueListenableBuilder<String?>(
          valueListenable: cubit.gender,
          builder: (context, value, child) => RadioGroup<String>(
            key: const Key(WidgetsKeys.kApplyScreenRadioGroup),
            onChanged: (value) {
              cubit.gender.value = value;
            },
            groupValue: cubit.gender.value,
            child: Row(
              children: [
                const Radio<String>(value: ConstKeys.kMale),
                Text(
                  key: const Key(WidgetsKeys.kApplyScreenTextMale),
                  local.male,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Radio<String>(value: ConstKeys.kFemale),
                Text(
                  key: const Key(WidgetsKeys.kApplyScreenTextFemale),
                  local.female,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
