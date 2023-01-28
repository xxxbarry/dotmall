import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:routemaster/routemaster.dart';

import '../../app/app.dart';
import '../../core/widgets/widgets.dart';
import '../../l10n/l10n.dart';
import '../bloc/auth_bloc.dart';
import '../../core/helpers/heplers.dart';
import '../helpers/helpers.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);
  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView>
    with AuthMixin<AuthView>, SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 20))
        ..repeat();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              "http://app.hvips.com/images/wp3.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: -200,
            left: -100,
            right: -100,
            child: ShaderMask(
              shaderCallback: (rect) {
                return CGradientBox.gradient
                    .createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.srcIn,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Transform.rotate(
                  angle: 17 * pi / 180,
                  child: SizedBox.square(
                    dimension: 380,
                    child: Center(
                      child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _controller.value * 2 * pi,
                              child: SvgPicture.asset(
                                "assets/images/SVG/zigzag.svg",
                                width: 300,
                                height: 300,
                                fit: BoxFit.contain,
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // get app name form context (internationalization)
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Center(
                child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      var text = AppLocalizations.of(context)
                          .counterAppBarTitle
                          .toUpperCase();
                      return Text(
                        ">" +
                            text.substring(
                                0,
                                (_controller.value * (text.length + 1))
                                    .floor()) +
                            "_",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            color: Colors.white.withOpacity(0.8),
                            letterSpacing: 10),
                      );
                    })),
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
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            var _loading = (state is AuthLoadingState);
                            return Column(
                              children: [
                                FormElementBox(
                                  child: ElevatedButton.icon(
                                    onPressed: _loading ? null : openSignDailog,
                                    label: Text('SGININ'.toUpperCase()),
                                    icon: _loading
                                        ? SquareProgressIndicator(
                                            size: 24,
                                            color: Theme.of(context).cardColor)
                                        : const Icon(
                                            FluentIcons.key_16_regular),
                                  ),
                                ),
                                FormElementBox(
                                  child: OutlinedButton.icon(
                                    onPressed: _loading
                                        ? null
                                        : () => openSignDailog(
                                            action: SignAction.signup),
                                    label: Text('SGINUP'.toUpperCase()),
                                    icon: _loading
                                        ? SquareProgressIndicator(size: 24)
                                        : const Icon(
                                            FluentIcons.person_16_regular),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const FormElementBox(
                        child: Text(
                          'By continuing, you agree to our Terms and Conditions and Privacy Policy.',
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
    );
  }
}

/// [AuthMixin] is a mixin that provides [openLoginDailog] to confirm auth
mixin AuthMixin<T extends StatefulWidget> on State<T> {
  final _authFormKey = GlobalKey<FormState>();
  final _authCountryCodeTextController = TextEditingController(text: "213");
  final _authPhoneTextEditingController = TextEditingController();
  final _authPasswordTextEditingController = TextEditingController();

  UserAuthCredentials? _authValidatedUserAuthCredentials() {
    if (_authFormKey.currentState!.validate()) {
      var phone = _authPhoneTextEditingController.text;
      // if starts with 0 delete it
      if (phone.startsWith('0')) {
        phone = phone.substring(1);
      }
      return UserAuthCredentials(
        username: _authCountryCodeTextController.text + phone,
        password: _authPasswordTextEditingController.text,
      );
    }
    return null;
  }

  void _authSigninButtonAction() {
    var _creditials = _authValidatedUserAuthCredentials();
    if (_creditials != null) {
      context.read<AuthBloc>()
        ..add(
          AuthSigninEvent(_creditials),
        );
    }
  }

  void _authSignupButtonAction() {
    var _creditials = _authValidatedUserAuthCredentials();
    if (_creditials != null) {
      context.read<AuthBloc>()
        ..add(
          AuthSigupEvent(_creditials),
        );
    }
  }

  final _authCancelToken = CancelToken();

  Future<AuthResponse?> openSignDailog(
      {SignAction action = SignAction.signin}) async {
    return await showDialogModalBottomSheet<AuthResponse>(
      context: context,
      builder: (context) {
        var _authBloc = context.read<AuthBloc>();
        var _phoneFocus = FocusNode();
        return BlocProvider.value(
          value: _authBloc,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthResponseState) {
                App.router.pop<AuthResponse>(state.response);
              }
            },
            child: FormElementBox.parent(
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  var _loading = (state is AuthLoadingState);
                  return StatefulBuilder(builder: (context, setState) {
                    return DisabledBox(
                      note: SquareProgressIndicator(),
                      // enabled: !_loading,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              action == SignAction.signin ? 'SGININ' : 'SGINUP',
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Form(
                            key: _authFormKey,
                            child: Column(
                              children: [
                                FormElementBox(
                                  child: CustomFormInput(
                                    focusNode: _phoneFocus,
                                    enabled: !_loading,
                                    errorText: state
                                        .asOrNull<AuthValidationExceptionState>(
                                            state)
                                        ?.exception
                                        .find("username")
                                        ?.message,
                                    controller: _authPhoneTextEditingController,
                                    formKey: _authFormKey,
                                    prefixIcon:
                                        const Icon(FluentIcons.call_16_regular),
                                    labelText: 'Phone number',
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      return FormValidators.phone(value);
                                    },
                                    suffix: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Text("+213"),
                                    ),
                                  ),
                                ),
                                FormElementBox(
                                  child: CustomFormInput(
                                    enabled: !_loading,
                                    errorText: state
                                        .asOrNull<AuthValidationExceptionState>(
                                            state)
                                        ?.exception
                                        .find("password")
                                        ?.message,
                                    controller:
                                        _authPasswordTextEditingController,
                                    formKey: _authFormKey,
                                    obscureText: true,
                                    prefixIcon:
                                        const Icon(FluentIcons.key_16_regular),
                                    labelText: 'password',
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (value) {
                                      return FormValidators.password(value);
                                    },
                                  ),
                                ),
                                if (action == SignAction.signin)
                                  FormElementBox(
                                    child: ElevatedButton.icon(
                                      onPressed: _loading
                                          ? null
                                          : _authSigninButtonAction,
                                      label: const Text('SGININ'),
                                      icon: _loading
                                          ? SquareProgressIndicator(
                                              size: 24,
                                              color:
                                                  Theme.of(context).cardColor)
                                          : const Icon(
                                              FluentIcons.key_16_regular),
                                    ),
                                  ),
                                if (action == SignAction.signup)
                                  FormElementBox(
                                    child: OutlinedButton.icon(
                                      onPressed: _loading
                                          ? null
                                          : _authSignupButtonAction,
                                      label: const Text('SGINUP'),
                                      icon: _loading
                                          ? SquareProgressIndicator(
                                              size: 24,
                                              color:
                                                  Theme.of(context).cardColor)
                                          : const Icon(
                                              FluentIcons.person_12_regular),
                                    ),
                                  ),
                                // if already have an account, go to signin
                                // else go to signup
                                FormElementBox(
                                  child: TextButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        // focus the phone text field
                                        _phoneFocus.requestFocus();
                                        action = action == SignAction.signin
                                            ? SignAction.signup
                                            : SignAction.signin;
                                      });
                                    },
                                    label: action == SignAction.signin
                                        ? const Text('NEW USER?')
                                        : const Text('HAVE AN ACCOUNT?'),
                                    icon: const Icon(
                                        FluentIcons.arrow_right_12_regular),
                                  ),
                                ),
                                const FormElementBox(
                                  child: Text(
                                    'By continuing, you agree to our Terms and Conditions and Privacy Policy',
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
                  });
                },
              ),
            ),
          ),
        );
      },
    ).whenComplete(() => _authCancelToken.cancel());
  }

  /// when dispose, cancel the auth cancel token
  @override
  void dispose() {
    _authCancelToken.cancel();
    super.dispose();
  }
}

// enum CButtonLoadingType {
//   linear,
//   circular,
// }

// class CButtonLoading {
//   final CButtonLoadingType type;
//   final double? value;

//   const CButtonLoading({
//     this.type = CButtonLoadingType.linear,
//     this.value,
//   });
// }

// class CButton extends StatefulWidget {
//   final bool enabled;
//   final bool loading;
//   final VoidCallback? onPressed;
//   final VoidCallback? onLongPress;
//   final ValueChanged<bool>? onHover;
//   final ValueChanged<bool>? onFocusChange;
//   final ButtonStyle? style;
//   final Clip clipBehavior;
//   final FocusNode? focusNode;
//   final bool autofocus;
//   final Widget child;

//   CButton({
//     super.key,
//     required this.onPressed,
//     required this.onLongPress,
//     required this.onHover,
//     required this.onFocusChange,
//     required this.style,
//     required this.focusNode,
//     required this.autofocus,
//     required this.clipBehavior,
//     this.enabled = true,
//     this.loading = false,
//     required this.child,
//   });

//   @override
//   State<CButton> createState() => _CButtonState();
// }

// class _CButtonState extends State<CButton> {
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       key: widget.key,
//       onPressed: widget.onPressed,
//       onLongPress: widget.onLongPress,
//       onHover: widget.onHover,
//       onFocusChange: widget.onFocusChange,
//       style: widget.style,
//       focusNode: widget.focusNode,
//       autofocus: widget.autofocus,
//       clipBehavior: widget.clipBehavior,
//       child: widget.child,
//     );
//   }
// }
