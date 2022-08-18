import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum SignAction {
  signin,
  signup,
  signout,
}

///
Future<T?> showDialogModalBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
}) async {
  return await showModalBottomSheet<T>(
    backgroundColor: Colors.transparent,
    elevation: 0,
    barrierColor: Colors.black12,
    isScrollControlled: true,
    anchorPoint: const Offset(0, 0.5),
    enableDrag: true,
    context: context,
    builder: (context) {
      return Wrap(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(21),
              constraints: const BoxConstraints(
                maxWidth: 400,
              ),
              child: Dialog(
                insetPadding: const EdgeInsets.all(0),
                child: builder(context),
              ),
            ),
          )
        ],
      );
    },
  );
}
