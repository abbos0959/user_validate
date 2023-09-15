import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:user/data/categories.dart';
import 'package:user/data/dummy_item.dart';
import 'package:user/widgets/new_item.dart';

class GroceyList extends StatefulWidget {
  const GroceyList({super.key});

  @override
  State<GroceyList> createState() => _GroceyListState();
}

class _GroceyListState extends State<GroceyList> {
  void _addItem(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewItem()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("bu grocey"),
          actions: [
            IconButton(
                onPressed: () {
                  _addItem(context);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: ListView.builder(
            itemCount: groceryItems.length,
            itemBuilder: (ctx, index) => ListTile(
                  title: Text(groceryItems[index].name),
                  leading: Container(
                      width: 24,
                      height: 24,
                      color: groceryItems[index].category.color),
                  trailing: Text(groceryItems[index].quantity.toString()),
                )));
  }
}
