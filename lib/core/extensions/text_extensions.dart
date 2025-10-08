import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle withBodySmall(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!;
  }

  TextStyle withBodyMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!;
  }

  TextStyle withBodyLarge(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!;
  }

  TextStyle withHeadlineMedium(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!;
  }

  TextStyle withHeadlineSmall(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!;
  }

  TextStyle withLabelSmall(BuildContext context) {
    return Theme.of(context).textTheme.labelSmall!;
  }
}