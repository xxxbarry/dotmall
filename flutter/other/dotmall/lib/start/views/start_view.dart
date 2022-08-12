import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/widgets/elements.dart';
import '../../l10n/l10n.dart';
import '../bloc/start_bloc.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var read = BlocProvider.of<StartBloc>(context).state;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppLogo(),
          // space
          const SizedBox(height: 10),
          // App name
          Text(
            AppLocalizations.of(context).counterAppBarTitle,
            style: Theme.of(context).textTheme.headline5,
          ),
          // space
          const SizedBox(height: 0),
          // App description
          Opacity(
            opacity: 0.5,
            child: Text(
              AppLocalizations.of(context).description,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          // space
          const SizedBox(height: 20),
          // Lineire progress indicator
          SquareProgressIndicator(),
        ],
      ),
    );
  }
}
