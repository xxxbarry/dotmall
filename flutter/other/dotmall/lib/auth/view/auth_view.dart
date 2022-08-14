import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

import '../../app/app.dart';
import '../../core/widgets/widgets.dart';
import '../../start/bloc/start_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../../core/helpers/heplers.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);
  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with AuthMixin<AuthView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthResponseState) {
          // pop if can
          if (Navigator.canPop(context)) {
            Navigator.pop<AuthResponse>(context, state.response);
          } else {
            /// var redirectTo = RouteData.of(context).queryParameters['redirectTo'];
            App.router.push("/");
          }
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              body: SizedBox(
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/1000w/element_001.png',
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.fill,
                      ),
                    ),
                    // get app name form context (internationalization)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Text(
                        context
                            .read<AuthBloc>()
                            .repository
                            .collection
                            .manager
                            .configs
                            .prodEndpoint,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: FormElementBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: CGradientBox(
                                    child: AppLogo(),
                                  ),
                                ),
                                FormElementBox(
                                  child: ElevatedButton.icon(
                                    onPressed: openSigninDailog,
                                    label: Text('تسجيل الدخول'.toUpperCase()),
                                    icon:
                                        const Icon(FluentIcons.key_16_regular),
                                  ),
                                ),
                                FormElementBox(
                                  child: BlocBuilder<StartBloc, StartState>(
                                    builder: (context, state) {
                                      return OutlinedButton.icon(
                                        onPressed: () async {
                                          context
                                              .read<StartBloc>()
                                              .add(StartRequestEvent());
                                          // var data = await manager.categories.create(
                                          //   options: CollectionPostOptions(
                                          //     data: FormData.fromMap(
                                          //       {
                                          //         'name': 'test',
                                          //         'description': 'test',
                                          //         'photo': await MultipartFile.fromFile(
                                          //           'assets/images/200w/logo_black.png',
                                          //           filename: 'logo_black.png',
                                          //         ),
                                          //       },
                                          //     ),
                                          //   ),
                                          // );

                                          // var data = await manager.categories.update(
                                          //   'xvFy69eKzWvv9X',
                                          //   options: CollectionPostOptions(
                                          //     data: FormData.fromMap(
                                          //       {
                                          //         'name': 'testsregerg',
                                          //         'description': 'testergerger',
                                          //         'photo': await MultipartFile.fromFile(
                                          //           'assets/images/200w/logo_black.png',
                                          //           filename: 'logo_black.png',
                                          //         ),
                                          //       },
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        label: Text('إنشاء حساب'.toUpperCase()),
                                        icon: const Icon(
                                            FluentIcons.person_16_regular),
                                      );
                                    },
                                  ),
                                ),
                                const FormElementBox(
                                  child: Text(
                                    'بالمتابعة ، فإنك توافق على الشروط والأحكام وسياسة الخصوصية الخاصة بنا.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state is AuthLoadingState) ...[
              Container(
                color: Colors.grey.withOpacity(0.2),
                child: Center(
                  child: SquareProgressIndicator(),
                ),
              ),
            ]
          ],
        );
      },
    );
  }
}

/// [AuthMixin] is a mixin that provides [openLoginDailog] to confirm auth
mixin AuthMixin<T extends StatefulWidget> on State<T> {
  final _formKey = GlobalKey<FormState>();
  final _countryCodeTextController = TextEditingController(text: "213");
  final _phoneTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  _signinButtonAction() {
    if (_formKey.currentState!.validate()) {
      var phone = _phoneTextEditingController.text;
      // if starts with 0 delete it
      if (phone.startsWith('0')) {
        phone = phone.substring(1);
      }
      context.read<AuthBloc>()
        ..add(
          AuthSigninEvent(
            UserAuthCredentials(
              username: _countryCodeTextController.text + phone,
              password: _passwordTextEditingController.text,
            ),
          ),
        );
    }
  }

  Future<AuthResponse?> openSigninDailog() async {
    var _authBloc = context.read<AuthBloc>();
    return await showModalBottomSheet<AuthResponse>(
      backgroundColor: Colors.transparent,
      elevation: 0,
      barrierColor: Colors.black12,
      isScrollControlled: true,
      anchorPoint: const Offset(0, 0.5),
      enableDrag: true,
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: _authBloc,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthResponseState) {
                App.router.pop<AuthResponse>(state.response);
              }
            },
            child: Wrap(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(21),
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                    ),
                    child: Dialog(
                      insetPadding: const EdgeInsets.all(0),
                      child: FormElementBox.parent(
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return DisabledBox(
                              note: SquareProgressIndicator(),
                              enabled: !(state is AuthLoadingState),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('تسجيل الدخول',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        FormElementBox(
                                          child: CustomFormInput(
                                            errorText: state
                                                .returnAs<
                                                        AuthValidationExceptionState>(
                                                    state)
                                                ?.exception
                                                .find("username")
                                                ?.message,
                                            controller:
                                                _phoneTextEditingController,
                                            formKey: _formKey,
                                            prefixIcon: const Icon(
                                                FluentIcons.call_16_regular),
                                            labelText: 'رقم الهاتف',
                                            keyboardType: TextInputType.phone,
                                            validator: (value) {
                                              return FormValidators.phone(
                                                  value);
                                            },
                                            suffix: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Text("+213"),
                                            ),
                                          ),
                                        ),
                                        FormElementBox(
                                          child: CustomFormInput(
                                            errorText: state
                                                .returnAs<
                                                        AuthValidationExceptionState>(
                                                    state)
                                                ?.exception
                                                .find("password")
                                                ?.message,
                                            controller:
                                                _passwordTextEditingController,
                                            formKey: _formKey,
                                            obscureText: true,
                                            prefixIcon: const Icon(
                                                FluentIcons.key_16_regular),
                                            labelText: 'كلمة المرور',
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            validator: (value) {
                                              return FormValidators.password(
                                                  value);
                                            },
                                          ),
                                        ),
                                        FormElementBox(
                                          child: ElevatedButton(
                                              onPressed: _signinButtonAction,
                                              child:
                                                  const Text('تسجيل الدخول')),
                                        ),
                                        const FormElementBox(
                                          child: Text(
                                            'بالمتابعة ، فإنك توافق على الشروط والأحكام وسياسة الخصوصية الخاصة بنا.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
