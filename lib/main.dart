import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'DHK 방문자 관리';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text("방문자 이름"),
                  ),
                  Container(
                      width: 200,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return '방문자 이름을 입력해주세요.';
                          }
                          return null;
                        },
                      )
                  )

                ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text("방문자 소속"),
                  ),
                  Container(
                      width: 200,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return '방문자 소속을 입력해주세요.';
                          }
                          return null;
                        },
                      )
                  )

                ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text("방문 목적"),
                  ),
                  Container(
                      width: 200,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return '방문 목적을 입력해주세요.';
                          }
                          return null;
                        },
                      )
                  )

                ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text("접견자 이름"),
                  ),
                  Container(
                      width: 200,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return '접견자 이름을 입력해주세요.';
                          }
                          return null;
                        },
                      )
                  )

                ]
            ),
          ),
        ],
      ),
    );
  }
}