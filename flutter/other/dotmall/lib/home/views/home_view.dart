import 'dart:async';

import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../category/widgets/widgets.dart';
import '../../core/widgets/collection_widgets.dart';
import '../../core/widgets/widgets.dart';
import '../../l10n/l10n.dart';
import '../bloc/home_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prooductsPanelController =
        StreamController<CollectionPanelEvent>.broadcast();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 40,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(FluentIcons.list_16_regular),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: CGradientBox(child: AppLogo.square(30)),
        actions: [
          IconButton(
            icon: Icon(FluentIcons.cart_16_regular),
            onPressed: () {},
          ),
        ],
      ),
      body: ScrollableArea(
        onEnd: (metrics) async {
          prooductsPanelController.add(CollectionPanelLoadMoreEvent());
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
              ),
              child: TextField(
                decoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(top: 5.5),
                  hintText: "Search for ?",
                  prefixIcon: Icon(FluentIcons.search_16_regular),
                  suffix: TextButton(
                    onPressed: () {},
                    child: Text("بحث"),
                  ),
                ),
              ),
            ),
            CollectionListPanel<Categories, Category>(
              collection: Categories(Manager(context.read<HomeBloc>().configs)),
              handlers: CollectionEventHandlers(),
              scrollDirection: Axis.horizontal,
              scrollable: true,
              gridCount: 1,
              onItemPressed: (List<Model> selections, model) {
                selections.clear();
                selections.add(model);
              },
              itemBuilder: (context, panel, model, state) {
                return CategoryCard(
                    selected: false,
                    onPressed: panel.onItemPressed == null
                        ? null
                        : () {
                            panel.onItemPressed!(state.selections, model!);
                          },
                    model: model);
              },
            ),
            CollectionListPanel<Stores, Store>(
              collection: Stores(Manager(context.read<HomeBloc>().configs)),
              handlers: CollectionEventHandlers(),
              scrollDirection: Axis.horizontal,
              scrollable: true,
              gridCount: 2,
              onItemPressed: (List<Model> selections, model) {
                selections.clear();
                selections.add(model);
              },
              itemBuilder: (context, panel, model, state) {
                return SizedBox(
                  width: 170,
                  child: SemanticCard(
                    model == null ? null : panel.collection.semanticsOf(model),
                    onPressed: () {},
                  ),
                );
              },
            ),
            CollectionListPanel<Products, Product>(
              controller: prooductsPanelController,
              collection: Products(Manager(context.read<HomeBloc>().configs)),
              handlers: CollectionEventHandlers(),
              scrollDirection: Axis.vertical,
              scrollable: false,
              gridCount: 2,
              itemBuilder: (context, panel, model, state) {
                return SemanticCard(
                  model == null ? null : panel.collection.semanticsOf(model),
                  onPressed: () {},
                  style: SemanticCardStyle(
                    leadingAspectRatio: 1,
                    leadingWidth: double.infinity,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textAlignment: CrossAxisAlignment.center,
                    direction: Axis.vertical,
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
