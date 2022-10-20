import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/home/widgets/todo_card_filter.dart';

class HomeFilters extends StatefulWidget {
  const HomeFilters({Key? key}) : super(key: key);

  @override
  State<HomeFilters> createState() => _HomeFiltersState();
}

class _HomeFiltersState extends State<HomeFilters> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'FILTROS',
          style: context.titleStyle,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            const TodoCardFilter(),
            const TodoCardFilter(),
            const TodoCardFilter(),
            Container(
              color: Colors.red,
              width: 100,
              height: 100,
            ),
            Container(
              color: Colors.blue,
              width: 100,
              height: 100,
            ),
            Container(
              color: Colors.red,
              width: 100,
              height: 100,
            ),
          ]),
        )
      ],
    );
  }
}
