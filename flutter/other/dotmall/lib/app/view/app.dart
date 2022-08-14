// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_repository.dart';
import '../../category/bloc/category_bloc.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/views/home_view.dart';
import '../../l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:routemaster/routemaster.dart';

import '../../auth/view/auth_view.dart';
import '../../start/bloc/start_bloc.dart';
import '../../start/views/start_view.dart';

class App extends StatelessWidget {
  const App({super.key});
  static var _routes = RouteMap(
    routes: {
      '/start': (_) => const MaterialPage(child: StartView()),
      '/auth': (_) => const MaterialPage(child: AuthView()),
      '/': (_) => const MaterialPage(child: HomeView()),

      // '/feed': (_) => MaterialPage(child: FeedPage()),
      // '/settings': (_) => MaterialPage(child: SettingsPage()),
      // '/feed/profile/:id': (info) => MaterialPage(
      //   child: ProfilePage(id: info.pathParameters['id'])
      // ),
    },
  );
  static var router = RoutemasterDelegate(routesBuilder: (context) => _routes);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StartBloc>(
      create: (context) => StartBloc(const Configs())..add(StartRequestEvent()),
      child: BlocBuilder<StartBloc, StartState>(
        buildWhen: (_, __) => true,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(
                create: (_) => AuthBloc(
                  AuthRepository(
                      collection:
                          Users(Manager(context.read<StartBloc>().configs))),
                )..add(AuthLoadingCacheEvent()),
              ),
              // HomeBloc
              BlocProvider<HomeBloc>(
                create: (_) => HomeBloc(),
              ),
              BlocProvider<CategoryBloc>(
                create: (_) => CategoryBloc(
                    Categories(Manager(context.read<StartBloc>().configs))),
              ),
            ],
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  color: Colors.transparent,
                  elevation: 0,
                  titleTextStyle: TextStyle(),
                  toolbarTextStyle: TextStyle(),
                  iconTheme: IconThemeData(),
                ),
                primarySwatch: Colors.purple,
                outlinedButtonTheme: OutlinedButtonThemeData(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(0, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                dialogTheme: DialogTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                inputDecorationTheme: const InputDecorationTheme(),
                buttonBarTheme: const ButtonBarThemeData(
                  buttonTextTheme: ButtonTextTheme.accent,
                ),
                buttonTheme: const ButtonThemeData(
                  height: 45,
                  buttonColor: Colors.purple,
                  textTheme: ButtonTextTheme.primary,
                ),
                textTheme: GoogleFonts.readexProTextTheme(
                  Theme.of(context).textTheme.copyWith(
                        caption: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.2),
                      ),
                ),
              ),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: AppLocalizations.supportedLocales[1],
              supportedLocales: AppLocalizations.supportedLocales,
              routerDelegate: router,
              routeInformationParser: RoutemasterParser(),
            ),
          );
        },
      ),
    );
  }
}
