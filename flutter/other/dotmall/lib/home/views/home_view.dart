import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../category/bloc/category_bloc.dart';
import '../../category/widgets/widgets.dart';
import '../../core/widgets/elements.dart';
import '../../core/widgets/widgets.dart';
import '../../l10n/l10n.dart';
import '../bloc/home_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(40),
        //   child: CGradientBox(
        //     enabled: false,
        //     child:
        //   ),
        // ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
            ),
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                isCollapsed: true,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 5.5),
                hintText: "تبحث عن شيء ما؟",
                prefixIcon: Icon(FluentIcons.search_16_regular),
                suffix: TextButton(
                  onPressed: () {},
                  child: Text("بحث"),
                ),
              ),
            ),
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              return CollectionBox<Category>(
                title: "الأقسام",
                axis: Axis.horizontal,
                collection: context.read<CategoryBloc>().repository,
                builder: (model) => CategoryCard(model),
              );
            },
          ),

          const SizedBox(height: 250),
          // Lineire progress indicator
          SizedBox(height: 40, child: Center(child: SquareProgressIndicator())),
        ],
      ),
    );
  }
}

class CollectionBox<T extends Model> extends StatelessWidget {
  final Collection<T> collection;
  final String title;
  final Widget? icon;
  final Axis axis;
  final Widget Function(T model) builder;
  const CollectionBox({
    super.key,
    required this.title,
    required this.collection,
    required this.builder,
    this.icon,
    this.axis = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    // add event ro bloc to load data
    context.read<CategoryBloc>().add(LoadCategoryEvent());
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon ?? Icon(FluentIcons.box_16_regular, size: 18),
                SizedBox(width: 8),
                Text(
                  title,
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
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: axis,
              children: [
                for (var i = 0; i < 10; i++)
                  builder(
                    Category(
                      id: "89e8r7gerg",
                      name: "قسم هنا",
                      description: "هذا وصف لفئة معينة",
                    ) as T,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
