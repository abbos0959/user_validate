import 'package:flutter/material.dart';
import 'package:user/data/categories.dart';

import 'package:user/models/grocery_item.dart';
import 'package:user/widgets/new_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroceyList extends StatefulWidget {
  const GroceyList({super.key});

  @override
  State<GroceyList> createState() => _GroceyListState();
}

class _GroceyListState extends State<GroceyList> {
  String? error;
  @override
  void initState() {
    super.initState();
    readData();
  }

  void _addItem(BuildContext context) async {
    await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (ctx) => const NewItem()));
    // setState(() {
    //   _groceryItems.add(newItem);
    // });
  }

  void _removegrocery(GroceryItem item) async {
    var url =
        'https://flutter-37804-default-rtdb.firebaseio.com/data/${item.id}.json';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        print('Ma\'lumot o\'chirildi');
      } else {
        print('Ma\'lumot o\'chirilmadi. HTTP xato: ${response.statusCode}');
      }
    } catch (error) {
      print('Xatolik yuz berdi: $error');
    }

    // final response = await http.get(Uri.parse(url));
    // await http.delete(Uri.parse(url));

    setState(() {
      list.remove(item);
    });
  }

  bool isLoading = true;
  List<GroceryItem> lis = [];
  List<GroceryItem> list = [];
  void readData() async {
    var url =
        "https://flutter-37804-default-rtdb.firebaseio.com/" + "data.json";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode >= 400) {
      print("object");
      setState(() {
        error = "apida qandaydir xatolik bor uka sanda ayb yo'q";
      });
    }
    final Map<String, dynamic> extractedData = json.decode(response.body);

    for (final item in extractedData.entries) {
      final category = categories.entries
          .firstWhere(
              (element) => element.value.title == item.value["category"])
          .value;
      lis.add(
        GroceryItem(
            id: item.key,
            name: item.value["name"],
            quantity: item.value["quantity"],
            category: category),
      );
    }

    setState(() {
      list = lis;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text("ma'lumot topilmadi"));
    if (isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (list.isNotEmpty) {
      content = ListView.builder(
        itemCount: list.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removegrocery(list[index]);
          },
          key: ValueKey(list[index].id),
          child: ListTile(
            title: Text(list[index].name),
            leading: Container(
                width: 24, height: 24, color: list[index].category.color),
            trailing: Text(list[index].quantity.toString()),
          ),
        ),
      );
    }

    if (error != null) {
      content = Center(
        child: Text(error!),
      );
    }
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
        body: content);
  }
}
