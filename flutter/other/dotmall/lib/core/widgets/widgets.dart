// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../category/bloc/category_bloc.dart';
import '../../category/widgets/widgets.dart';
import '../repositories/repositories.dart';
import 'collection_widgets.dart';
import 'elements.dart';

export 'buttons.dart';
export 'elements.dart';
export 'gradient_box.dart';
export 'inputs.dart';

import '../../core/helpers/heplers.dart';

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
    return child;
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
  final T? model;

  const ModelCard({super.key, this.model});
}
/*
class CategoryCollectionBox extends StatefulWidget {
  const CategoryCollectionBox({super.key});

  @override
  State<CategoryCollectionBox> createState() => _CategoryCollectionBoxState();
}

class _CategoryCollectionBoxState extends State<CategoryCollectionBox> {
  List<Category> data = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<CategoryBloc>().add(CategoryLoadEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CollectionPanelSimpleHead(
          title: Text('الفئات'),
          icon: Icon(FluentIcons.apps_16_regular),
        ),
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            return SizedBox(
              child: CollectionBoxBody<Category>(
                scrollable: true,
                loading: state is CategoryLoadingState,
                direction: Axis.horizontal,
                data: context.read<CategoryBloc>().cache.models,
                onLoadMore: (nextPage) async {
                  context.read<CategoryBloc>().add(
                        CategoryLoadEvent(
                            options: CategoryListOptions(page: nextPage)),
                      );
                },
                meta: state is CategoryLoadedState ? state.response.meta : null,
                itemBuilder: (model) {
                  return CategoryCard(model: model);
                },
              ),
            );
          },
        )
      ],
    );
  }
}

/// [CollectionBox]

class CollectionBox<T extends Model> extends StatefulWidget {
  final Collection<T> collection;
  final CachePaginatedModel<T> cache;
  final String title;
  final Widget? icon;
  final Axis axis;
  final Widget child;

  final VoidCallback? onLoad;
  final void Function(int page)? onRefresh;
  final void Function(int page)? onLoadMore;

  const CollectionBox({
    super.key,
    required this.title,
    required this.collection,
    required this.child,
    this.icon,
    this.axis = Axis.vertical,
    required this.cache,
    this.onLoad,
    this.onRefresh,
    this.onLoadMore,
  });

  @override
  State<CollectionBox<T>> createState() => _CollectionBoxState<T>();
}

class _CollectionBoxState<T extends Model> extends State<CollectionBox<T>> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      widget.onLoad?.call();
    });
    super.initState();
  }

  int page = 1;

  _next() async {
    var response = await widget.collection.listR(
        options: RequestOptions(
      queryParameters: {'page': page + 1},
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.icon ?? Icon(FluentIcons.box_16_regular, size: 18),
                SizedBox(width: 8),
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text("المزيد"),
                ),
              ],
            ),
          ),
          //ListView horizontal
          widget.child
        ],
      ),
    );
  }
}

/// [CollectionBoxBody]
class CollectionBoxBody<T extends Model> extends StatefulWidget {
  final bool loading;
  final bool scrollable;
  final bool showArrows;
  final Axis direction;
  final Function(T model) itemBuilder;
  final List<T> data;

  final PaginationMeta? meta;

  final VoidCallback? onLoad;
  final Future<void> Function(int page)? onRefresh;
  final Future<void> Function(int page)? onLoadMore;

  CollectionBoxBody(
      {super.key,
      this.loading = true,
      this.scrollable = true,
      this.showArrows = true,
      required this.direction,
      required this.itemBuilder,
      this.meta,
      this.data = const [],
      this.onLoad,
      this.onRefresh,
      this.onLoadMore});

  @override
  State<CollectionBoxBody<T>> createState() => _CollectionBoxBodyState<T>();
}

class _CollectionBoxBodyState<T extends Model>
    extends State<CollectionBoxBody<T>> {
  ScrollController? _scrollController;
  ValueNotifier<ScrollMetrics?> _scrollPositionNotifier = ValueNotifier(null);
  initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  bool _loadingMore = false;
  Future<void> _onLoadMore() async {
    if (!_loadingMore && widget.meta != null) {
      if (widget.meta!.currentPage < widget.meta!.lastPage) {
        setState(() {
          _loadingMore = true;
        });
        await widget.onLoadMore?.call(widget.meta!.currentPage + 1);
        setState(() {
          _loadingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var _child = Flex(
      direction: widget.direction,
      children: [
        for (var model in widget.data) widget.itemBuilder(model),
      ],
    );
    return Stack(
      children: [
        Text(widget.meta?.currentPage.toString() ?? "0"),
        DisabledBox(
          enabled: widget.loading,
          child: widget.scrollable && widget.data.isNotEmpty
              ? SizedBox(
                  height: 90,
                  child: NotificationListener(
                    onNotification: (dynamic notification) {
                      if (notification is ScrollMetricsNotification ||
                          notification is ScrollUpdateNotification ||
                          notification is ScrollStartNotification) {
                        _scrollPositionNotifier.value = notification.metrics;
                        if (_scrollPositionNotifier.value!.pixels >
                            _scrollPositionNotifier.value!.maxScrollExtent /
                                1.7) {
                          _onLoadMore();
                        }
                      }
                      return false;
                    },
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: widget.direction,
                      child: _child,
                      physics: const AlwaysScrollableScrollPhysics(),
                    ),
                  ),
                )
              : _child,
        ),
        if (widget.loading)
          Center(
            child: SquareProgressIndicator(),
          ),
        if (widget.scrollable &&
            widget.direction == Axis.horizontal &&
            widget.showArrows) ...[
          Positioned(
            left: 10,
            top: 10,
            child: ValueListenableBuilder<ScrollMetrics?>(
                valueListenable: _scrollPositionNotifier,
                builder: (context, value, child) {
                  return AnimatedScale(
                    scale: value != null &&
                            value.extentBefore != value.maxScrollExtent
                        ? 1
                        : 0,
                    duration: Duration(milliseconds: 300),
                    child: Center(
                      child: FloatingActionButton.small(
                        backgroundColor: Theme.of(context).cardColor,
                        onPressed: () {
                          if (value != null)
                            _scrollController?.animateTo(
                              _scrollController!.position.pixels +
                                  value.extentInside / 2,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                            );
                        },
                        child: Icon(
                          FluentIcons.arrow_left_12_regular,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: ValueListenableBuilder<ScrollMetrics?>(
                valueListenable: _scrollPositionNotifier,
                builder: (context, value, child) {
                  return AnimatedScale(
                    scale: value != null && value.extentBefore != 0 ? 1 : 0,
                    duration: Duration(milliseconds: 300),
                    child: Center(
                      child: FloatingActionButton.small(
                        backgroundColor: Theme.of(context).cardColor,
                        onPressed: () {
                          if (value != null)
                            _scrollController?.animateTo(
                              _scrollController!.position.pixels -
                                  value.extentInside / 2,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                            );
                        },
                        child: Icon(
                          FluentIcons.arrow_right_12_regular,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ]
      ],
    );
  }
}
*/