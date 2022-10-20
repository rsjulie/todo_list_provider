import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _emailFocus = FocusNode();

  @override
  void initState() {
    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
            context: context,
            everCallback: ((notifier, listenerInstance) {
              if (notifier is LoginController) {
                if (notifier.hasInfo) {
                  Messages.of(context).showInfo(notifier.infoMessage!);
                }
              }
            }),
            successCallback: ((notifier, listenerInstance) {
              log('login executado com sucesso');
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth),
              child: IntrinsicHeight(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  const TodoListLogo(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TodoListField(
                            controller: _emailEC,
                            label: 'E-mail',
                            validator: Validatorless.multiple([
                              Validatorless.required('Email obrigatório'),
                              Validatorless.email('Email inválido'),
                            ]),
                            focusNode: _emailFocus,
                          ),
                          const SizedBox(height: 20),
                          TodoListField(
                            controller: _passwordEC,
                            label: 'Senha',
                            obscureText: true,
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha obrigatória'),
                              Validatorless.min(6,
                                  'Senha deve conter pelo menos 6 caracteres')
                            ]),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  if (_emailEC.text.isNotEmpty) {
                                    context
                                        .read<LoginController>()
                                        .forgotPassword(_emailEC.text);
                                  } else {
                                    _emailFocus.requestFocus();
                                    Messages.of(context).showError(
                                        'Digite um e-mail para recuperar a senha');
                                  }
                                },
                                child: const Text('Esqueceu sua senha?'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  var formValid =
                                      _formKey.currentState?.validate() ??
                                          false;
                                  if (formValid) {
                                    var email = _emailEC.text;
                                    var password = _passwordEC.text;
                                    context
                                        .read<LoginController>()
                                        .login(email, password);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Login'),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffF0F3F7),
                        border: Border(
                          top: BorderSide(
                            width: 2,
                            color: Colors.grey.withAlpha(50),
                          ),
                        ),
                      ),
                      child: Column(children: [
                        const SizedBox(height: 30),
                        SignInButton(
                          Buttons.Google,
                          text: 'Continue com o Google',
                          onPressed: () {
                            context.read<LoginController>().googleLogin();
                          },
                          padding: const EdgeInsets.all(5),
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Não tem conta?'),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/register');
                              },
                              child: const Text(
                                'Cadastre-se',
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  )
                ],
              )),
            ),
          );
        },
      ),
    );
  }
}
