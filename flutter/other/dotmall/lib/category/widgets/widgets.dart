import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/helpers/heplers.dart';
import '../../core/widgets/collection_widgets.dart';
import '../../core/widgets/widgets.dart';
import '../../start/bloc/start_bloc.dart';

class CategoryCard extends ModelCard<Category> {
  CategoryCard({super.key, super.model});

  @override
  Widget build(BuildContext context) {
    var configs = context.read<StartBloc>().configs;
    return Container(
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(1.3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: model != null ? null : Colors.grey.withOpacity(0.2),
                gradient: model == null ? null : CGradientBox.gradient,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border:
                      Border.all(color: Theme.of(context).cardColor, width: 2),
                  // image
                  image: model?.photos.isNotEmpty ?? false
                      ? DecorationImage(
                          image: NetworkImage(
                              configs.makeUrl(model!.photos.first.path)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: model?.photos.isEmpty ?? true
                    ? Opacity(
                        opacity: model == null ? 0.2 : 0.5,
                        child: (Center(
                          child: Icon(
                            FluentIcons.circle_image_20_filled,
                            size: 30,
                          ),
                        )),
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPlaceholder(
                  width: 40,
                  enabled: model == null,
                  child: Text(
                    model?.name.clipAt(8) ?? '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          height: 1.3,
                        ),
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
