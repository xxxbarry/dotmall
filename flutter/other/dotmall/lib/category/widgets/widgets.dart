import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/widgets.dart';

class CategoryCard extends ModelCard<Category> {
  CategoryCard(super.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Icon(
                  FluentIcons.image_20_regular,
                  size: 30,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        height: 1.3,
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}






















// class CategoryCard extends ModelCard<Category> {
//   CategoryCard(super.model, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(4),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           AspectRatio(
//             aspectRatio: 1,
//             child: Container(
//               margin: const EdgeInsets.all(4),
//               decoration: BoxDecoration(
//                 color: Colors.grey.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Center(
//                 child: Icon(
//                   FluentIcons.image_20_regular,
//                   size: 30,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(4),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   model.name,
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                         height: 1.3,
//                       ),
//                 ),
//                 Text(
//                   model.description ?? "No description",
//                   style: Theme.of(context).textTheme.caption,
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
