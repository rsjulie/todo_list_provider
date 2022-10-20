import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key? key}) : super(key: key);

  final nameVN = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
          decoration: BoxDecoration(color: context.primaryColor.withAlpha(70)),
          child: Row(
            children: [
              Selector<AuthProvider, String>(builder: (_, value, __) {
                return CircleAvatar(
                  backgroundImage: NetworkImage(value),
                );
              }, selector: ((context, authProvider) {
                return authProvider.user?.photoURL ??
                    'https://cdn-icons-png.flaticon.com/512/1057/1057231.png?w=360';
              })),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Selector<AuthProvider, String>(builder: (_, value, __) {
                    return Text(
                      value,
                      style: context.textTheme.subtitle2,
                    );
                  }, selector: ((context, authProvider) {
                    return authProvider.user?.displayName ??
                        'Usuário não informado';
                  })),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            showDialog(
              context: context,
              builder: ((context) {
                return AlertDialog(
                  title: const Text('Alterar nome'),
                  content: TextField(
                    onChanged: (value) {
                      nameVN.value = value;
                    },
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.red),
                        )),
                    TextButton(
                        onPressed: () {
                          var name = nameVN.value;
                          if (name.isEmpty) {
                            Messages.of(context).showError('Nome obrigatório');
                          } else {
                            Loader.show(context);
                            context.read<UserService>().updateDisplayName(name);
                            Loader.hide();
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Alterar')),
                  ],
                );
              }),
            );
          },
          title: const Text('Alterar Nome'),
        ),
        ListTile(
            onTap: () {
              context.read<AuthProvider>().logout();
            },
            title: const Text('Sair')),
      ]),
    );
  }
}
