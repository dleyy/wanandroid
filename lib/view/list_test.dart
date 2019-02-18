import 'package:flutter/material.dart';

class ListTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _List();
}

class _List extends State<ListTest> with SingleTickerProviderStateMixin {
  List<Widget> items;

  TabController _controller;

  @override
  void initState() {
    super.initState();
    items = [
      GestureDetector(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Text("333"),
        ),
        onTap: () {
          setState(() {
            List<Widget> _items = items;
            _items.add(Text("333"));
            items = _items;
            print("123");
          });
        },
      ),
      Text("444")
    ];
    _controller = TabController(length: items.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: TabBarView(controller: _controller, children: [
        Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return items[index];
            },
            itemCount: items.length,
          ),
        )
      ]),
    );
  }
}
