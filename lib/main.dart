library Constants;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:dhk_visitor_management_app/InputSpreadSheetUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/google_sheet_controller.dart';

void main() => runApp(MyApp());

final appTitle = 'DHK 방문자 관리';

const String spreadSheetKey = 'spreadSheetKey';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFD61F26),
        accentColor: Colors.deepOrange,
      ),
      routes: routes,
    );
  }
}

final routes = {
  '/': (BuildContext context) => new Splash(),
  '/form': (BuildContext context) => new MyCustomForm(),
  '/spread_sheet': (BuildContext context) => new InputSpreadSheetUrl()
};

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 1,
      navigateAfterSeconds: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          leading: IconButton(
              padding: const EdgeInsets.only(left: 15.0),
              icon: Image.asset('images/delivery_hero_logo.png')),
        ),
        body: StreamBuilder<String>(
            stream: GoogleSheetController.INSTANCE.urlStream,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return FutureBuilder<String>(
                  future: getSpreadSheetKey(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.data != null) {
                      return MyCustomForm();
                    } else {
                      return InputSpreadSheetUrl();
                    }
                  },
                );
              }
              else
                return WebView(
                  initialUrl: snapshot.data,
                  userAgent: 'Chrome/56.0.0.0 Mobile',
                  javascriptMode: JavascriptMode.unrestricted,
                  navigationDelegate: (request) {
                    if (request.url.startsWith(
                        'https://accounts.google.com/o/oauth2/approval?as=')) {
                      setState(() {});
                    }
                  },
                  onPageFinished: (url) {
                    print('onPageFinished $url');
                  },
                );
            }),
      ),
      image: new Image.network(
          'https://deliveryhero.co.kr/public/images/footer_logo.png'),
      backgroundColor: Colors.white,
      loaderColor: Colors.red,
      photoSize: 200.0,
    );
  }

  Future<String> getSpreadSheetKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(spreadSheetKey);
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

  final _visitDateController = TextEditingController();
  final _visitorNameController = TextEditingController();
  final _visitorCompanyController = TextEditingController();
  final _welcomerNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String visitDropdownValue = "방문 본부를 선택해주세요.";
  var visitItems = <String>[
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
  final format = DateFormat("yyyy-MM-dd");

  String dropDownResidenceTimeValue = "체류 시간을 선택해주세요.";
  var residenceTimeItems = <String>[
    '체류 시간을 선택해주세요.',
    '1시간',
    '2시간',
    '3시간',
    '4시간',
    '5시간',
    '6시간',
    '7시간',
    '종일'
  ];

  String purposeDropdownValue = "방문 목적을 선택해주세요.";
  var purposeItems = <String>[
    '방문 목적을 선택해주세요.',
    '시스템 점검',
    '업체미팅',
    '자사직원손님',
    '면접'
  ];

  DateTime selectedDate = DateTime.now();
  TextEditingController dateCtl = TextEditingController(text: DateFormat("yyyy-MM-dd").format(DateTime.now()));

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
                      controller: dateCtl,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());

                        selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2016),
                            lastDate: DateTime.now()
                        );

                        dateCtl.text = format.format(selectedDate);
                      },
                    ),
                  ),
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text("체류 시간"),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: dropDownResidenceTimeValue,
                        onChanged: (String newValue) {
                          setState(() {
                            dropDownResidenceTimeValue = newValue;
                          });
                        },
                        items: residenceTimeItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox.expand(
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
                    child: Text("방문자 이름"),
                  ),
                  Expanded(child: TextFormField(
                    controller: _visitorNameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '방문자 이름을 입력해주세요.';
                      }
                      return null;
                    },
                  )),
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
                  Expanded(child: TextFormField(
                    controller: _visitorCompanyController,
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
                      child: Text("방문 목적"),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: purposeDropdownValue,
                        onChanged: (String newValue) {
                          setState(() {
                            purposeDropdownValue = newValue;
                          });
                        },
                        items: purposeItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox.expand(
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
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text("방문 본부"),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: visitDropdownValue,
                        onChanged: (String newValue) {
                          setState(() {
                            visitDropdownValue = newValue;
                          });
                        },
                        items: visitItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox.expand(
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 16.0),
                  child: Row(children: <Widget>[
                    Container(
                      width: 100,
                      child: Text("접견자 이름"),
                    ),
                    Expanded(child: TextFormField(
                      controller: _welcomerNameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return '접견자 이름을 입력해주세요.';
                        }
                        return null;
                      },
                    ))
                  ])),
              SizedBox(
                height: 30.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                width: double.infinity,
                child: RaisedButton(
                  child: Text(
                    "제출하기",
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.all(12.0),
                  shape: StadiumBorder(),
                  color: Colors.red,
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (visitDropdownValue == visitItems[0]) {
                      toast(visitDropdownValue);
                    } else if (purposeDropdownValue == purposeItems[0]) {
                      toast(purposeDropdownValue);
                    } else if (dropDownResidenceTimeValue ==
                        residenceTimeItems[0]) {
                      toast(dropDownResidenceTimeValue);
                    } else if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.

                      String visitDate = new DateFormat("yyyy.MM.dd").format(
                          new DateFormat("yyyy-MM-dd").parse(_visitDateController.text)
                      );
                      String residenceTime = dropDownResidenceTimeValue;
                      String visitorName = _visitorNameController.text;
                      String visitorCompany = _visitorCompanyController.text;
                      String visitPurpose = purposeDropdownValue;
                      String visitDepartment = visitDropdownValue;
                      String welcomerName = _welcomerNameController.text;

                      GoogleSheetController.INSTANCE.requestSheetInfo(visitDate, residenceTime, visitorName, visitorCompany, visitPurpose, visitDepartment, welcomerName);

                      // print test
                      print(visitDate);
                      print(residenceTime);
                      print(visitorName);
                      print(visitorCompany);
                      print(visitPurpose);
                      print(visitDepartment);
                      print(welcomerName);

                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('제출하는 중입니다.')));
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
