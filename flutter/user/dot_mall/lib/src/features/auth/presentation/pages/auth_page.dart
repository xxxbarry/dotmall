import 'package:dio/dio.dart';
import 'package:dot_mall/src/features/auth/domain/entities/auth.dart';
import 'package:dot_mall/src/features/core/presentation/widgets/gradient_box.dart';
import 'package:dot_mall/src/features/core/presentation/widgets/inputs.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:dot_mall/src/features/core/dot_mall_sdk/dot_mall_sdk.dart'
    as api;

import '../../../core/dot_mall_sdk/collections/collection.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);
  static const routeName = '/auth';

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            child: Image.asset(
                              'assets/images/200w/logo_black.png',
                              width: 50,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        FormElementBox(
                          child: ElevatedButton.icon(
                            onPressed: _openLoginDailog,
                            label: Text('تسجيل الدخول'.toUpperCase()),
                            icon: const Icon(FluentIcons.key_16_regular),
                          ),
                        ),
                        FormElementBox(
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              var manager = api.Manager(
                                configs: api.Configs(prodEndpoint: ""),
                              );
                              manager.init();
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

                              var data = await manager.categories
                                  .delete('iY31XQi7K84Jcv');
                              print(data);
                            },
                            label: Text('إنشاء حساب'.toUpperCase()),
                            icon: const Icon(FluentIcons.person_16_regular),
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
    );
  }

  final _formKey = GlobalKey<FormState>();

  void _openLoginDailog() async {
    final result = await showModalBottomSheet<Auth>(
      backgroundColor: Colors.transparent,
      elevation: 0,
      barrierColor: Colors.black12,
      isScrollControlled: true,
      anchorPoint: const Offset(0, 0.5),
      enableDrag: true,
      context: context,
      builder: (context) {
        return Wrap(
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
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('تسجيل الدخول',
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              FormElementBox(
                                child: CustomFormInput(
                                  formKey: _formKey,
                                  prefixIcon:
                                      const Icon(FluentIcons.call_16_regular),
                                  labelText: 'رقم الهاتف',
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    return FormValidators.phone(value);
                                  },
                                ),
                              ),
                              FormElementBox(
                                child: CustomFormInput(
                                  formKey: _formKey,
                                  obscureText: true,
                                  prefixIcon:
                                      const Icon(FluentIcons.key_16_regular),
                                  labelText: 'كلمة المرور',
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    return FormValidators.password(value);
                                  },
                                ),
                              ),
                              FormElementBox(
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('تسجيل الدخول')),
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
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
