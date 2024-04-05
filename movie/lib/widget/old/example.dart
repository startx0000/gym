import 'package:flutter/material.dart';


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _selectedItems = [];
  List<String> _items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Multiple Selection Dropdown'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Select Items',
                ),
                items: _items.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (selectedItem) {
                  setState(() {
                    if (_selectedItems.contains(selectedItem)) {
                      _selectedItems.remove(selectedItem);
                    } else {
                      _selectedItems.add(selectedItem!);
                    }
                  });
                },

                value: _selectedItems.isNotEmpty ? _selectedItems[0] : null,
                isExpanded: true,

                // multiple: true, // This allows multiple selection
              ),
              SizedBox(height: 20),
              Text(
                'Selected Items: ${_selectedItems.join(", ")}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}