import 'package:flutter/material.dart';
import 'package:user/data/categories.dart';
import 'package:user/models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formkey = GlobalKey<FormState>();
  var _enterName = "";
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;

  void _saveItam() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      var url =
          "https://flutter-37804-default-rtdb.firebaseio.com/" + "data.json";

      try {
        final response = await http.post(
          Uri.parse(url),
          body: json.encode({
            "name": _enterName,
            "quantity": _enteredQuantity,
            "category": _selectedCategory.title
          }),
        );
        // Navigator.of(context).pop();
      } catch (error) {
        throw error;
      }
    }

    if (!context.mounted) {
      return;
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("yangi Item qo'shish")),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length == 1 ||
                          value.trim().length > 40) {
                        return "To'g'ri ma'lumot kirit qovoqbosh";
                      }
                      return null;
                    },
                    maxLength: 40,
                    decoration: const InputDecoration(label: Text("Name")),
                    onSaved: (newValue) {
                      _enterName = newValue!;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.tryParse(value) == null ||
                                int.tryParse(value)! <= 0) {
                              return "To'g'ri quantity kirit qovoqbosh";
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(label: Text("quantity")),
                          keyboardType: TextInputType.number,
                          initialValue: _enteredQuantity.toString(),
                          onSaved: (newValue) {
                            _enteredQuantity = int.parse(newValue!);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: DropdownButtonFormField(
                            value: _selectedCategory,
                            items: [
                              for (final cate in categories.entries)
                                DropdownMenuItem(
                                  value: cate.value,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        color: cate.value.color,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(cate.value.title)
                                    ],
                                  ),
                                )
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value!;
                              });
                            }),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            _formkey.currentState!.reset();
                          },
                          child: const Text(
                            "restart",
                            style: TextStyle(color: Colors.white),
                          )),
                      ElevatedButton(
                          onPressed: _saveItam,
                          child: const Text(
                            "Item Qo'shish",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  )
                ],
              ))),
    );
  }
}
