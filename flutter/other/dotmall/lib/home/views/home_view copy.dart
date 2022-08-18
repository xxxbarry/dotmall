import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../category/bloc/category_bloc.dart';
import '../../category/widgets/widgets.dart';
import '../../core/repositories/repositories.dart';
import '../../core/widgets/collection_widgets.dart';
import '../../core/widgets/elements.dart';
import '../../core/widgets/widgets.dart';
import '../../l10n/l10n.dart';
import '../bloc/home_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    var read = BlocProvider.of<HomeBloc>(context).state;
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
      body: SingleChildScrollView(
        controller: _scrollController,
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
            CollectionPanel<Categories, Category>(
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
                    selected: false, onPressed: () {}, model: model);
              },
            ),
            CollectionPanel<Stores, Store>(
              collection: Stores(Manager(context.read<HomeBloc>().configs)),
              handlers: CollectionEventHandlers(),
              scrollDirection: Axis.horizontal,
              scrollable: true,
              gridCount: 2,
              onItemPressed: (List<Model> selections, model) {
                selections.clear();
                selections.add(model);
              },
            ),
            CollectionPanel<Categories, Category>(
              scrollController: _scrollController,
              collection: Categories(Manager(context.read<HomeBloc>().configs)),
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
            CollectionPanel<Categories, Category>(
              collection: Categories(Manager(context.read<HomeBloc>().configs)),
              handlers: CollectionEventHandlers(),
              scrollDirection: Axis.vertical,
              scrollable: false,
              gridCount: 1,
              itemBuilder: (context, panel, model, state) {
                return SemanticCard(
                  model == null ? null : panel.collection.semanticsOf(model),
                  onPressed: () {},
                  style: SemanticCardStyle(
                    leadingWidth: 50,
                    leadingHeight: 50,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    direction: Axis.horizontal,
                  ),
                );
              },
            ),
            CollectionPanel<Categories, Category>(
              collection: Categories(Manager(context.read<HomeBloc>().configs)),
              handlers: CollectionEventHandlers(),
              scrollDirection: Axis.horizontal,
              scrollable: true,
              gridCount: 1,
            ),
            const SizedBox(height: 250),
            // Lineire progress indicator
            SizedBox(
                height: 40, child: Center(child: SquareProgressIndicator())),
          ],
        ),
      ),
    );
  }
}
