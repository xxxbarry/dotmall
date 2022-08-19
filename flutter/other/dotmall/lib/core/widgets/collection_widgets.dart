// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart' hide RequestOptions;
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:dotmall_sdk/dotmall_sdk.dart';

import '../../core/helpers/heplers.dart';
import 'gradient_box.dart';
import 'widgets.dart';

enum ListViewMode {
  list,
  grid,
  slides,
}

class CollectionPanelEvent {}

/// CollectionPanelListEventsq
class CollectionPanelLoadListEvent extends CollectionPanelEvent {
  final ListRequestOptions? options;
  CollectionPanelLoadListEvent([this.options]);
}

///CollectionPanelLoadMoreEvent
class CollectionPanelLoadMoreEvent extends CollectionPanelEvent {
  final ListRequestOptions? options;
  CollectionPanelLoadMoreEvent([this.options]);
}

/// CollectionPanelCancelEvent
class CollectionPanelCancelEvent extends CollectionPanelEvent {
  CollectionPanelCancelEvent();
}

/// [CollectionPanelController] is a controller for [CollectionPanel] widget.
/// It is used to control the [CollectionPanel] widget.
class CollectionPanelController extends ValueNotifier<CollectionPanelEvent?> {
  CollectionPanelController(super.value);
}

/// [CollectionPanel] is a [StatefulWidget] designed to display a list of items from the
/// collection.
/// it also has some features like:
/// - load items
/// - load more items (next page)
/// - search items
/// - CRUD operations
/// - and more..
class CollectionPanel<C extends Collection, M extends Model>
    extends StatefulWidget {
  final C collection;
  final CollectionEventHandlers handlers;
  final bool scrollable;
  final Axis scrollDirection;
  final Size? bodySize;

  final double? mainAxisSizeItemSize;
  final double? crossAxisSizeItemSize;
  final ListViewMode mode;
  final int gridCount;

  /// builder body
  final Widget Function(BuildContext context, CollectionPanel<C, M> panel)?
      bodyBuilder;
  final Widget Function(BuildContext context, CollectionPanel<C, M> panel)?
      headBuilder;
  final Widget Function(BuildContext context, CollectionPanel<C, M> panel,
      M? model, _CollectionPanelState<C, M> state)? itemBuilder;
  final void Function(List<M> selections, M model)? onItemPressed;
  final ScrollController? scrollController;
  final StreamController<CollectionPanelEvent>? controller;
  const CollectionPanel({
    super.key,
    required this.collection,
    required this.handlers,
    this.scrollDirection = Axis.vertical,
    this.headBuilder,
    this.bodyBuilder,
    this.itemBuilder,
    this.scrollable = true,
    this.mode = ListViewMode.grid,
    this.gridCount = 2,
    this.bodySize,
    this.mainAxisSizeItemSize,
    this.crossAxisSizeItemSize,
    this.onItemPressed,
    this.scrollController,
    this.controller,
  });

  @override
  State<CollectionPanel<C, M>> createState() => _CollectionPanelState<C, M>();
}

class _CollectionPanelState<C extends Collection, M extends Model>
    extends State<CollectionPanel<C, M>> {
  late final StreamController<CollectionPanelEvent> controller;
  final CancelToken cancelToken = CancelToken();
  final _responses = <PaginatedModel<M>>[];

  List<M> get items => _responses.isEmpty
      ? []
      : _responses.fold(<M>[], (items, response) => items + response.data);

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  void initState() {
    controller =
        widget.controller ?? StreamController<CollectionPanelEvent>.broadcast();
    controller.stream.listen((event) {
      if (event is CollectionPanelLoadListEvent) {
        _listLoad(event.options);
      } else if (event is CollectionPanelLoadMoreEvent) {
        _listLoadMore(event.options);
      } else if (event is CollectionPanelCancelEvent) {
        _cancel();
      }
    });
    super.initState();
  }

  // _cancel
  void _cancel() {
    setState(() {
      cancelToken.cancel();
    });
  }

  Future<void> _showMessage(String message, {Function? refresh}) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('حدثت مشكلة'),
          content: Text(
            message,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          actions: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  if (refresh != null)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: Icon(FluentIcons.arrow_clockwise_12_regular),
                        label: Text('أعد المحاولة'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          refresh.call();
                        },
                      ),
                    ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      child: Text('حسنا'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _listLoad([ListRequestOptions? requestOptions]) async {
    requestOptions = requestOptions ?? _requestOptions;
    if (_listLoading || !mounted) {
      return;
    }
    setState(() {
      _listError = false;
      _listLoading = true;
    });
    await Future.delayed(Duration(milliseconds: 5000));
    try {
      CancelToken cancelToken = CancelToken();
      widget.handlers.onListLoading(cancelToken);
      await Future.delayed(Duration(milliseconds: 1500));
      var response = await widget.collection
          .listR(options: requestOptions.copyWith(cancelToken: cancelToken));
      var parsedRespose =
          widget.collection.paginatedModelFromMap(response.data!);
      widget.handlers.onListLoaded(parsedRespose);
      _responses.add(parsedRespose as PaginatedModel<M>);
      setState(() {});
    } on ValidationException catch (e) {
      _listError = true;
      widget.handlers.onListValidationException(e);
      _showMessage("حدثت مشكلة أثناء تحميل البيانات", refresh: _listLoad);
    } on DioError catch (e) {
      _listError = true;
      widget.handlers.onListDioError(e);
      var errorMessage = e.error.toString().contains(".message")
          ? e.error.toString().split(".").first
          : e.error.toString();
      _showMessage(errorMessage, refresh: _listLoad);
    } catch (e) {
      _listError = true;
      widget.handlers.onListError(e);
      _showMessage(e.toString(), refresh: _listLoad);
    }
    setState(() {
      widget.handlers.onListSetState(context);
      _listLoading = false;
    });
  }

  Future<void> _listLoadMore([ListRequestOptions? requestOptions]) async {
    requestOptions = requestOptions ?? _requestOptions;
    if (_hasMore) {
      _requestOptions = _requestOptions.copyWith(
        page: _responses.last.meta.currentPage + 1,
      );
      await _listLoad();
    }
  }

  var _requestOptions = ListRequestOptions();
  var _listLoading = false;
  var _listError = false;
  bool get _listLoadMoreError => _listError || _responses.isEmpty;
  bool get _hasMore =>
      _responses.isNotEmpty &&
      _responses.last.meta.currentPage < _responses.last.meta.lastPage;
  List<M> selections = [];
  Widget _itemBuilder(BuildContext context, CollectionPanel<C, M> panel,
      M? model, _CollectionPanelState<C, M> state) {
    if (panel.itemBuilder != null) {
      return panel.itemBuilder!(context, panel, model, this);
    }
    return SemanticCard(
      selected: selections.contains(model),
      model == null ? null : widget.collection.semanticsOf(model),
      onPressed: model == null
          ? null
          : () {
              setState(() {
                widget.onItemPressed?.call(selections, model);
              });
            },
      style: SemanticCardStyle(direction: panel.scrollDirection),
    );
  }

  bool get _showPlaceholder =>
      (items.isEmpty && _listLoading) || _listLoading || _hasMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.headBuilder?.call(context, widget) ??
            CollectionPanelSimpleHead(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.collection.table),
                ],
              ),
              actions: [
                if (_responses.isNotEmpty)
                  Container(
                    height: 15,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${_responses.last.meta.currentPage}/${_responses.last.meta.lastPage}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 12,
                          ),
                    ),
                  ),
                SizedBox(width: 8),
                CGradientBox(
                  child: SizedBox(
                    height: 30,
                    child: TextButton(
                      onPressed: () {},
                      child: Icon(FluentIcons.arrow_clockwise_12_regular),
                    ),
                  ),
                ),
              ],
            ),
        ScrollableArea(
          controller: widget.scrollController,
          scrollable: widget.scrollable,
          direction: widget.scrollDirection,
          onInit: () {
            _listLoad();
          },
          onEnd: (m) => _listLoadMore(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: !_listLoading && items.isEmpty
                ? Container(
                    constraints: BoxConstraints(minHeight: 80),
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (_listError && _responses.isEmpty) ...[
                          Icon(
                            FluentIcons.window_apps_48_regular,
                            size: 35,
                            color: Theme.of(context)
                                .textTheme
                                .button!
                                .color!
                                .withOpacity(0.4),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'حدثت مشكلة أثناء تحميل البيانات',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                        ],
                        if (_responses.isNotEmpty && items.isEmpty) ...[
                          Icon(
                            FluentIcons.tv_usb_16_regular,
                            size: 35,
                            color: Theme.of(context)
                                .textTheme
                                .button!
                                .color!
                                .withOpacity(0.4),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'لا توجد بيانات',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .button!
                                        .color!
                                        .withOpacity(0.3)),
                          )
                        ],
                        SizedBox(height: 8),
                        OutlinedButton(
                          child: Text('أعد المحاولة'),
                          onPressed: _listLoad,
                        ),
                      ],
                    ),
                  )
                : FlexGrid(
                    direction: widget.scrollDirection,
                    mode: widget.mode,
                    childern: <Widget>[
                      for (var item in items)
                        _itemBuilder(context, widget, item, this),
                      if (_showPlaceholder)
                        for (var i in List.generate(
                            _hasMore ? widget.gridCount : 24, (index) => null))
                          _itemBuilder(context, widget, null, this),

                      // TODO: implement refresh load more
                      // if (_listLoadMoreError)
                      //   OutlinedButton(
                      //     child: Text('أعد المحاولة'),
                      //     onPressed: _listLoad,
                      //   ),
                    ],
                    margin: const EdgeInsets.all(4),
                    count: widget.gridCount,
                  ),
          ),
        )
      ],
    );
  }
}

class FlexGrid extends StatelessWidget {
  const FlexGrid({
    Key? key,
    required this.direction,
    required this.mode,
    required this.childern,
    required this.margin,
    required this.count,
  }) : super(key: key);

  final Axis direction;
  final ListViewMode mode;
  final List<Widget> childern;
  final EdgeInsets margin;
  final int count;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      return Flex(
        mainAxisSize: MainAxisSize.min,
        direction: direction,
        children: [
          if (mode == ListViewMode.slides) ...[
            for (var child in childern) ...[
              Padding(padding: margin, child: child),
            ]
          ] else if (mode == ListViewMode.grid) ...[
            for (var i = 0; i < childern.length; i += 2)
              if (i % count == 0)
                SizedBox(
                  width: direction == Axis.vertical ? box.maxWidth : null,
                  child: Flex(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    direction: direction == Axis.horizontal
                        ? Axis.vertical
                        : Axis.horizontal,
                    children: [
                      for (var j = 0; j < count; j++) ...[
                        if (i + j < childern.length)
                          Flexible(
                            flex: direction == Axis.horizontal ? 0 : 1,
                            child: SizedBox(
                              width: direction == Axis.vertical
                                  ? double.infinity
                                  : null,
                              child: Padding(
                                padding: margin,
                                child: childern[i + j],
                              ),
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
          ],
          // if (_hasMore) SquareProgressIndicator()
        ],
      );
    });
  }
}

class SemanticCardStyle {
  final bool? showLeading;
  final bool? showTitle;
  final bool? showSubtitle;

  final double? leadingAspectRatio;
  final double? leadingWidth;
  final double? leadingHeight;

  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final EdgeInsets? leadingPadding;

  final BoxDecoration? decoration;
  final BoxDecoration? leadingDecoration;
  final Axis? direction;

  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;

  final CrossAxisAlignment? textAlignment;

  final int? maxTitleLetters;
  final int? maxSubtitleLetters;

  final Widget? icon;

  const SemanticCardStyle({
    this.icon,
    this.showLeading,
    this.showTitle,
    this.showSubtitle,
    this.leadingDecoration,
    this.leadingAspectRatio,
    this.leadingWidth,
    this.leadingHeight,
    this.padding,
    this.margin,
    this.leadingPadding = const EdgeInsets.all(4),
    this.decoration,
    this.direction,
    this.textAlignment,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
    this.maxTitleLetters,
    this.maxSubtitleLetters,
  });
}

class SemanticCard<T extends Model> extends StatelessWidget {
  final SemanticCardMetaData? semantic;
  final SemanticCardStyle? style;
  final VoidCallback? onPressed;
  final bool selected;
  final bool disabled;
  const SemanticCard(
    this.semantic, {
    super.key,
    this.style,
    this.onPressed,
    this.selected = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    var image = semantic?.image as File?;
    var _direction = style?.direction ?? Axis.horizontal;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: style?.decoration ??
          BoxDecoration(
            color: selected
                ? Theme.of(context).primaryColor.withOpacity(0.2)
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: semantic == null
                    ? Colors.transparent
                    : (selected
                        ? Theme.of(context).primaryColor
                        : Colors.grey.withOpacity(0.3)),
                width: 1),
          ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: semantic == null ? null : onPressed,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Flex(
            direction: style?.direction ?? Axis.horizontal,
            mainAxisAlignment:
                style?.mainAxisAlignment ?? MainAxisAlignment.center,
            crossAxisAlignment: style?.crossAxisAlignment ??
                (_direction == Axis.horizontal
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start),
            mainAxisSize: style?.mainAxisSize ?? MainAxisSize.min,
            children: [
              if (style?.showLeading ?? true)
                Builder(builder: (context) {
                  Widget _child = Container(
                    margin: const EdgeInsets.all(4),
                    decoration:
                        ((semantic == null ? null : style?.leadingDecoration) ??
                                BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius:
                                      style?.leadingDecoration?.borderRadius ??
                                          BorderRadius.circular(8),
                                ))
                            .copyWith(
                      image: image != null
                          ? DecorationImage(
                              image:
                                  NetworkImage(Configs().makeUrl(image.path)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: image == null
                        ? Opacity(
                            opacity: semantic == null ? 0.2 : 0.5,
                            child: (style?.icon ??
                                Center(
                                  child: Icon(
                                    FluentIcons.circle_image_20_filled,
                                    size: 30,
                                  ),
                                )),
                          )
                        : null,
                  );
                  if (style?.leadingAspectRatio != null) {
                    return AspectRatio(
                      aspectRatio: style!.leadingAspectRatio!,
                      child: SizedBox(
                        width: style?.leadingWidth ?? 45,
                        height: style?.leadingHeight ?? 45,
                        child: AspectRatio(
                          aspectRatio: style?.leadingAspectRatio ?? 1,
                          child: _child,
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(
                      width: style?.leadingWidth ?? 45,
                      height: style?.leadingHeight ?? 45,
                      child: _child,
                    );
                  }
                }),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment:
                        style?.textAlignment ?? CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (style?.showTitle ?? true)
                        TextPlaceholder(
                          enabled: semantic == null,
                          child: Text(
                            semantic?.title
                                    ?.clipAt(style?.maxTitleLetters ?? 22) ??
                                "",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(height: 1.3),
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                      if (style?.showSubtitle ?? true)
                        TextPlaceholder(
                          width: 50,
                          enabled: semantic == null,
                          child: Text(
                            (semantic?.subtitle
                                    ?.clipAt(style?.maxTitleLetters ?? 22) ??
                                ""),
                            style: Theme.of(context).textTheme.caption,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextPlaceholder extends StatelessWidget {
  final bool enabled;
  final Widget? child;
  final int lines;
  final double height;
  final double width;

  const TextPlaceholder({
    super.key,
    this.enabled = true,
    this.lines = 1,
    this.child,
    this.height = 14,
    this.width = 90,
  });

  @override
  Widget build(BuildContext context) {
    var random = Random();
    return enabled
        ? Column(
            children: [
              for (var i = 0; i < lines; i++)
                Container(
                  height: height,
                  width: width,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
            ],
          )
        : child ?? SizedBox();
  }
}

class CollectionEventHandlers<C extends Collection, M extends Model> {
  void onListLoading(CancelToken cancelToken) {}

  void onListLoaded(PaginatedModel<M> response) {}

  void onListValidationException(ValidationException e) {}

  void onListDioError(DioError e) {}

  void onListError(Object e) {}

  void onListSetState(BuildContext context) {}
}

class ScrollableAreaArrows {
  final bool top;
  final bool bottom;
  final bool start;
  final bool end;
  const ScrollableAreaArrows({
    this.top = true,
    this.bottom = true,
    this.start = true,
    this.end = true,
  });
  // all
  factory ScrollableAreaArrows.all(bool visibility) => ScrollableAreaArrows(
        top: visibility,
        bottom: visibility,
        start: visibility,
        end: visibility,
      );
  // symmetric visible [vertical, horizontal]
  factory ScrollableAreaArrows.symmetric({bool? vertical, bool? horizontal}) =>
      ScrollableAreaArrows(
        top: vertical ?? true,
        bottom: vertical ?? true,
        start: horizontal ?? true,
        end: horizontal ?? true,
      );
}

class ScrollableArea extends StatefulWidget {
  final bool scrollable;
  final bool refreshable;
  final bool paginable;
  final ScrollableAreaArrows arrows;
  final bool showIndicator;
  final Axis direction;
  final void Function(ScrollMetrics metrics)? onRefresh;
  final Future<void> Function(ScrollMetrics metrics)? onEnd;
  final void Function(ScrollMetrics metrics)? onStart;
  final void Function(ScrollMetrics metrics)? onMiddle;
  final void Function()? onInit;
  final void Function(ScrollNotification notification)? onNotification;
  final ScrollController? controller;

  final Widget Function(BuildContext context, Widget? child,
      ValueNotifier<ScrollNotification?> notifier)? builder;
  final Widget child;

  const ScrollableArea(
      {super.key,
      required this.child,
      this.scrollable = true,
      this.refreshable = true,
      this.paginable = true,
      this.arrows = const ScrollableAreaArrows(),
      this.showIndicator = true,
      this.direction = Axis.vertical,
      this.onRefresh,
      this.onStart,
      this.onMiddle,
      this.onEnd,
      this.onNotification,
      this.onInit,
      this.controller,
      this.builder});

  @override
  State<ScrollableArea> createState() => _ScrollableAreaState();
}

class _ScrollableAreaState extends State<ScrollableArea> {
  ValueNotifier<ScrollNotification?> _notifier = ValueNotifier(null);
  late ScrollController? _controller;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onInit?.call();
    });
    _controller =
        widget.controller ?? (widget.scrollable ? ScrollController() : null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _builder = widget.builder ??
        (BuildContext context, Widget child,
            ValueNotifier<ScrollNotification?> notifier) {
          return widget.scrollable
              ? SingleChildScrollView(
                  controller: _controller,
                  scrollDirection: widget.direction,
                  child: child,
                  physics: const AlwaysScrollableScrollPhysics(),
                )
              : child;
        };
    // return _builder(context, widget.child, _notifier);
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollNotification) {
          _onNotification(notification);
        } else if (notification is ScrollMetricsNotification) {
          _onNotification(ScrollStartNotification(
            context: notification.context,
            metrics: notification.metrics,
          ));
        }
        return true;
      },
      child: Stack(
        children: [
          Positioned(child: _builder(context, widget.child, _notifier)),
          if (widget.scrollable || _controller != null) ...[
            if (widget.direction == Axis.horizontal) ...[
              Positioned(
                // textDirection: Directionality.of(context),
                right: 10,
                bottom: 0,
                top: 0,
                child: ScrollableAreaArrow(
                  show: widget.arrows.end,
                  controller: _controller!,
                  notifier: _notifier,
                  direction: ArrowDirection.right,
                ),
              ),
              Positioned(
                // textDirection: Directionality.of(context),
                // end: 10,
                left: 10,
                bottom: 0,
                top: 0,
                child: ScrollableAreaArrow(
                  show: widget.arrows.start,
                  controller: _controller!,
                  notifier: _notifier,
                  direction: ArrowDirection.left,
                ),
              ),
            ] else ...[
              Positioned.directional(
                textDirection: Directionality.of(context),
                start: 0,
                end: 0,
                top: 10,
                child: ScrollableAreaArrow(
                  show: widget.arrows.top,
                  controller: _controller!,
                  notifier: _notifier,
                  direction: ArrowDirection.top,
                ),
              ),
              Positioned.directional(
                textDirection: Directionality.of(context),
                end: 0,
                bottom: 10,
                start: 0,
                child: ScrollableAreaArrow(
                  show: widget.arrows.bottom,
                  controller: _controller!,
                  notifier: _notifier,
                  direction: ArrowDirection.bottom,
                ),
              ),
            ],
          ]
        ],
      ),
    );
  }

  void _onNotification(ScrollNotification notification) {
    _notifier.value = notification;
    ScrollMetrics metrics = notification.metrics;
    // if reached the end of the list, call onLoadMore
    if (widget.paginable && metrics.pixels == metrics.maxScrollExtent) {
      widget.onEnd?.call(metrics);
    }
    // if reached the top of the list, call onRefresh
    if (widget.refreshable && metrics.pixels == 0) {
      widget.onStart?.call(metrics);
    }
    // onMiddle of scrolling, call onMiddle
    if (widget.onMiddle != null) {
      widget.onMiddle?.call(metrics);
    }

    widget.onNotification?.call(notification);
  }
}

class ScrollableAreaArrow extends StatelessWidget {
  final ScrollController controller;
  final ValueListenable<ScrollNotification?> notifier;
  final ArrowDirection direction;
  final double rate;
  final Widget? icon;
  final bool show;

  const ScrollableAreaArrow(
      {super.key,
      required this.controller,
      required this.notifier,
      required this.direction,
      this.rate = 1,
      this.icon,
      this.show = true});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ScrollNotification?>(
        valueListenable: notifier,
        builder: (context, value, child) {
          return AnimatedScale(
            scale: _getScale(context, value),
            duration: Duration(milliseconds: 300),
            child: Center(
              child: FloatingActionButton.small(
                backgroundColor: Theme.of(context).cardColor,
                onPressed: () {
                  if (value != null) {
                    var dir = _selectDir(context);
                    controller.animateTo(
                      value.metrics.pixels +
                          value.metrics.extentInside / 2 * dir * rate,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Center(
                  child: RotatedBox(
                    quarterTurns: direction.quarterTurns,
                    child: icon ??
                        Icon(
                          FluentIcons.arrow_right_12_regular,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  int _selectDir(context) {
    if (direction == ArrowDirection.top) {
      return -1;
    } else if (direction == ArrowDirection.bottom) {
      return 1;
    } else if (direction == ArrowDirection.left) {
      if (Directionality.of(context) == TextDirection.ltr) {
        return -1;
      } else {
        return 1;
      }
    } else if (direction == ArrowDirection.right) {
      if (Directionality.of(context) == TextDirection.ltr) {
        return 1;
      } else {
        return -1;
      }
    } else {
      return 0;
    }
  }

  double _getScale(context, ScrollNotification? value) {
    if (!show) {
      return 0;
    }
    if (notifier.value != null) {
      var dir = _selectDir(context);
      if (value!.metrics.maxScrollExtent == 0) {
        return 0;
      }
      if (notifier.value!.metrics.pixels == 0 && dir == -1) {
        return 0;
      }
      if (notifier.value!.metrics.pixels ==
              notifier.value!.metrics.maxScrollExtent &&
          dir == 1) {
        return 0;
      }
      return 1;
    }
    return 0;
  }
}

enum ArrowDirection {
  top,
  bottom,
  right,
  left,
}

extension QuarterTurns on ArrowDirection {
  int get quarterTurns {
    switch (this) {
      case ArrowDirection.bottom:
        return 1;
      case ArrowDirection.left:
        return 2;
      case ArrowDirection.top:
        return 3;
      case ArrowDirection.right:
        return 4;
      default:
        return 1;
    }
  }

  Axis get axis {
    switch (this) {
      case ArrowDirection.bottom:
        return Axis.vertical;
      case ArrowDirection.left:
        return Axis.horizontal;
      case ArrowDirection.top:
        return Axis.vertical;
      case ArrowDirection.right:
        return Axis.horizontal;
      default:
        return Axis.horizontal;
    }
  }
}

///  [CollectionPanelSimpleHead]
class CollectionPanelSimpleHead extends StatelessWidget {
  final Widget? icon;
  final Widget title;
  final List<Widget>? actions;
  const CollectionPanelSimpleHead({
    super.key,
    this.icon,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox.square(
              dimension: 38,
              child: CGradientBox(
                  child: icon ?? Icon(FluentIcons.apps_16_regular))),
          SizedBox(width: 8),
          DefaultTextStyle(
              style: Theme.of(context).textTheme.subtitle1!, child: title),
          Spacer(),
          ...?actions,
        ],
      ),
    );
  }
}
