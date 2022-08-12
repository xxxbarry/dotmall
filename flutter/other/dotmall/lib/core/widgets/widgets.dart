// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:dotmall_sdk/dotmall_sdk.dart';

import 'elements.dart';

export 'buttons.dart';
export 'elements.dart';
export 'gradient_box.dart';
export 'inputs.dart';

/// [DisabledBox] is a widget that is used to disable a widget.
/// it has the property [enabled] to disable the widget.
/// [enabled] is true by default.
/// it used [Opacity] to make the widget transparent.
///  and [IgnorePointer] to disable the touch events.
class DisabledBox extends StatelessWidget {
  final bool enabled;
  final Widget child;
  final Widget? note;
  const DisabledBox({
    super.key,
    this.enabled = true,
    required this.child,
    this.note,
  });
  @override
  Widget build(BuildContext context) {
    var widget = child;
    if (!enabled) {
      widget = Opacity(
        opacity: 0.2,
        child: IgnorePointer(
          ignoring: true,
          child: child,
        ),
      );
      if (note != null) {
        widget = Stack(
          children: [
            widget,
            Positioned.fill(
              child: Center(child: note),
            ),
          ],
        );
      }
    }
    return widget;
  }
}

abstract class ModelCard<T extends Model> extends StatelessWidget {
  final T model;
  const ModelCard(
    this.model, {
    super.key,
  });
}
