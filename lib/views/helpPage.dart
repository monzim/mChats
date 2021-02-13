import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.amber,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.check),
                title: Text('TITLE'),
                subtitle: Text('SUBTITLE'),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('BTN1'),
                    onPressed: () {/* ... */},
                  ),
                  FlatButton(
                    child: const Text('BTN2'),
                    onPressed: () {/* ... */},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
