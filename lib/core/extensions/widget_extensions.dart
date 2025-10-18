import 'package:flutter/material.dart';

extension AddPaddingExtension on Widget {
  Widget withPadding({
    double? all,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Padding(
      padding: all != null
          ? EdgeInsets.all(all)
          : EdgeInsets.only(
              top: top ?? 0,
              bottom: bottom ?? 0,
              left: left ?? 0,
              right: right ?? 0,
            ),
      child: this,
    );
  }

  Widget withSymmetricPadding({double? horizontal, double? vertical}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal ?? 0,
        vertical: vertical ?? 0,
      ),
      child: this,
    );
  }

  Widget withMargin({
    double? all,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Container(
      margin: all != null
          ? EdgeInsets.all(all)
          : EdgeInsets.only(
              top: top ?? 0,
              bottom: bottom ?? 0,
              left: left ?? 0,
              right: right ?? 0,
            ),
      child: this,
    );
  }

  Widget withSymmetricMargin({double? horizontal, double? vertical}) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontal ?? 0,
        vertical: vertical ?? 0,
      ),
      child: this,
    );
  }

  Widget withVisibility({required bool visible}) {
    return Visibility(visible: visible, child: this);
  }
}
