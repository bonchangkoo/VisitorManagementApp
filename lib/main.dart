import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

final appTitle = 'DHK 방문자 관리';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFD61F26),
        accentColor: Colors.white,
      ),
      routes: routes,
    );
  }
}

final routes = {
  '/': (BuildContext context) => new Splash(),
  '/form': (BuildContext context) => new MyCustomForm()
};

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SplashState();
}

class SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 10,
      navigateAfterSeconds: new Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          leading: IconButton(
              padding: const EdgeInsets.only(left: 15.0),
              icon: Image.asset('images/delivery_hero_logo.png')
          ),
        ),
        body: new MyCustomForm(),
      ),
      image: new Image.network('https://deliveryhero.co.kr/public/images/footer_logo.png'),
      backgroundColor: Colors.white,
      loaderColor: Colors.red,
      photoSize: 200.0,
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
  String dropdownValue = "방문 본부를 선택해주세요.";
  var items = <String>[
    '방문 본부를 선택해주세요.',
    '재무본부',
    '전략본부',
    '기술연구소',
    '세일즈본부',
    '마케팅본부',
    '서비스운영본부',
    'Data실',
    '법무실',
    '홍보실',
    '플라이하이TF본부',
    '푸드플라이'
  ];

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: Row(children: <Widget>[
                  Container(
                    width: 100,
                    child: Text("방문 일자"),
                  ),
                  Expanded(
                      child: TextFormField(
                        initialValue:
                        DateFormat("yyyy-MM-dd").format(DateTime.now()),
                        validator: (value) {
                          if (value.isEmpty) {
                            return '방문 일자를 입력해주세요';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: true, signed: true),
                      ),
                  ),
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: Row(children: <Widget>[
                  Container(
                    width: 100,
                    child: Text("방문자 이름"),
                  ),
                  Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return '방문자 이름을 입력해주세요.';
                          }
                          return null;
                        },
                      ))
                ]),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: Row(children: <Widget>[
                  Container(
                    width: 100,
                    child: Text("방문자 소속"),
                  ),
                  Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return '방문자 소속을 입력해주세요.';
                          }
                          return null;
                        },
                      ))
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text("방문 본부"),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items:
                            items.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(
                              width: 300,
                              child: Text(value, textAlign: TextAlign.center),
                            ),
                          );
                        }).toList(),
                        isExpanded: true,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: Row(children: <Widget>[
                  Container(
                    width: 100,
                    child: Text("방문 목적"),
                  ),
                  Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return '방문 목적을 입력해주세요.';
                          }
                          return null;
                        },
                      ))
                ]),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 16.0),
                  child: Row(children: <Widget>[
                    Container(
                      width: 100,
                      child: Text("접견자 이름"),
                    ),
                    Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return '접견자 이름을 입력해주세요.';
                            }
                            return null;
                          },
                        ))
                  ])),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (dropdownValue == items[0]) {
                      Fluttertoast.showToast(
                          msg: dropdownValue,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );

                    } else if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('제출하는 중입니다.')));
                    }
                  },
                  child: Text('제출하기'),
                ),
              ),
            ],
          ),
        ));
  }
}
