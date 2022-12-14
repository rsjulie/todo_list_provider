import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/my_flutter_app_icons.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_filters.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_header.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_tasks.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_week_filter.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_module.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToCreateTask(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TasksModule().getPage('/task/create', context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home page'),
        iconTheme: IconThemeData(color: context.primaryColor),
        backgroundColor: const Color(0xFFFAFBFE),
        elevation: 0,
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem<bool>(
                  child: Text('Mostrar tarefas concluídas'))
            ],
            icon: const Icon(MyFlutterApp.filter),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primaryColor,
        onPressed: () => _goToCreateTask(context),
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color(0xFFFAFBFE),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: ((ctx, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: IntrinsicHeight(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      HomeHeader(),
                      HomeFilters(),
                      HomeWeekFilter(),
                      HomeTasks(),
                    ],
                  )),
                ),
              ),
            )),
      ),
    );
  }
}
