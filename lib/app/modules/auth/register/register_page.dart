import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/validators/validators.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController(text: 'julie@gmail.com');
  final _passwordEC = TextEditingController(text: '123456');
  final _confirmPasswordEC = TextEditingController(text: '123456');

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final defaultListener = DefaultListenerNotifier(
        changeNotifier: context.read<RegisterController>());
    defaultListener.listener(
        context: context,
        successCallback: (notifier, listenerInstance) {
          listenerInstance.dispose();
          Navigator.of(context).pop();
        });
    // context.read<RegisterController>().addListener(() {
    //   final controller = context.read<RegisterController>();
    //   final success = controller.success;
    //   final error = controller.error;

    //   if (success) {
    //     Navigator.of(context).pop();
    //   } else if (error != null && error.isNotEmpty) {}
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
                color: context.primaryColor,
              ),
            ),
          ),
        ),
        title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Todo List',
                style: TextStyle(
                    color: context.primaryColor, fontSize: 12, height: 1.4),
              ),
              Text(
                'Cadastro',
                style: TextStyle(
                    color: context.primaryColor, fontSize: 18, height: 1.2),
              ),
            ]),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.5,
            child: const FittedBox(
              fit: BoxFit.fitHeight,
              child: TodoListLogo(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                    ),
                    const SizedBox(height: 20),
                    TodoListField(
                      controller: _passwordEC,
                      label: 'Senha',
                      obscureText: true,
                      validator: Validatorless.multiple([
                        Validatorless.required('Senha obrigatória'),
                        Validatorless.min(
                            6, 'Senha deve ter pelo menos 6 caracteres'),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    TodoListField(
                      controller: _confirmPasswordEC,
                      label: 'Confirma Senha',
                      obscureText: true,
                      validator: Validatorless.multiple([
                        Validatorless.required('Campo obrigatório'),
                        Validators.comparre(
                            _passwordEC, 'Senha diferente de confirma senha')
                      ]),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          final formValid =
                              _formKey.currentState?.validate() ?? false;
                          if (formValid) {
                            final email = _emailEC.text;
                            final password = _passwordEC.text;
                            context
                                .read<RegisterController>()
                                .registerUser(email, password);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Salvar'),
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
