import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:user/data/categories.dart';
import 'package:user/data/dummy_item.dart';
import 'package:user/models/grocery_item.dart';
import 'package:user/widgets/new_item.dart';

class GroceyList extends StatefulWidget {
  const GroceyList({super.key});

  @override
  State<GroceyList> createState() => _GroceyListState();
}

class _GroceyListState extends State<GroceyList> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem(BuildContext context) async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (ctx) => const NewItem()));

    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
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
                icon: const Icon(Icons.add))
          ],
        ),
        body: ListView.builder(
            itemCount: _groceryItems.length,
            itemBuilder: (ctx, index) => ListTile(
                  title: Text(_groceryItems[index].name),
                  leading: Container(
                      width: 24,
                      height: 24,
                      color: _groceryItems[index].category.color),
                  trailing: Text(_groceryItems[index].quantity.toString()),
                )));
  }
}
