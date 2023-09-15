import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:user/data/categories.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("yangi Item qo'shish"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  return "sasa";
                },
                maxLength: 40,
                decoration: const InputDecoration(label: Text("Name")),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(label: Text("quantity")),
                      initialValue: "1",
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(items: [
                      for (final cate in categories.entries)
                        DropdownMenuItem(
                          value: cate.value,
                          child: Expanded(
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
                          ),
                        )
                    ], onChanged: (value) {}),
                  )
                ],
              )
            ],
          ))),
    );
  }
}
