import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart' as Constants;

class InputSpreadSheetUrl extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _spreadSheetUrlController = TextEditingController();

  void putSpreadSheetKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.spreadSheetKey, key);
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

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              child: Row(children: <Widget>[
                Container(
                  width: 120,
                  child: Text("SpreadSheetUrl"),
                ),
                Expanded(
                    child: TextFormField(
                  controller: _spreadSheetUrlController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'URL을 입력해주세요';
                    }
                    return null;
                  },
                )),
              ]),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              width: double.infinity,
              child: RaisedButton(
                child: Text(
                  "Spread Sheet Url 등록",
                  style: TextStyle(color: Colors.white),
                ),
                padding: EdgeInsets.all(12.0),
                shape: StadiumBorder(),
                color: Colors.red,
                onPressed: () {
                  print("${_spreadSheetUrlController.text}");
                  if (_formKey.currentState.validate()) {
                    print("${_spreadSheetUrlController.text}");
                    Uri uri = Uri.parse(_spreadSheetUrlController.text);
                    List<String> pathSegments= uri.pathSegments;
                    String key;
                    for (var i = 0; i< pathSegments.length; i++) {
                      print("${pathSegments[i]}");
                      if (pathSegments[i] == 'd') {
                        if (i + 2 < pathSegments.length && pathSegments[i + 2].contains("edit")) {
                          key = pathSegments[i +1];
                          putSpreadSheetKey(key);
                        }
                      }
                    }
                    if (key == null) {
                      toast("Spread Sheet Url이 정상적이지 않습니다.");
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => Constants.MyCustomForm()
                      ));
                    }
                  }
                },
              ),
            ),
          ],
        ));
  }
}
