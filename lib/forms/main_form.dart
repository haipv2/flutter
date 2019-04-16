import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form validation demo';
    FocusNode myFocusNode = new FocusNode();

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(myFocusNode),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            FocusScope.of(context).requestFocus(myFocusNode);
          },
          tooltip: 'Focus Second Textfield',
          child: Icon(Icons.edit),
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  FocusNode myFocusNode;

  MyCustomForm(this.myFocusNode);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
    widget.myFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'text field',
              border: InputBorder.none,
              hintText: 'enter something',
            ),
          ),
          TextFormField(
            focusNode: widget.myFocusNode,
            decoration: InputDecoration(labelText: 'input text form field'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please input something';
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
