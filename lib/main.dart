import 'package:flutter/material.dart';
import 'party.dart';
import 'package:flutter/gestures.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/LICENSES.txt');
}

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

//State is information of the application that can change over time or when some actions are taken.
class _State extends State<MyApp> {
  bool _katakana = true;
  bool _hiragana = true;
  bool _isButtonDisabled = false;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _katakanaChanged(bool value) => setState(() => _katakana = value);
  void _hiraganaChanged(bool value) => setState(() => _hiragana = value);

  void __isButtonDisabledChanged() {
    _isButtonDisabled = _katakana || _hiragana ? false : true;
  }

  void _showLicense() async{
    String data =  await loadAsset();
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Licenses"),
          content: new SingleChildScrollView (
            child: Text(data) ,
          )

          ,
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey.shade900,
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'nihonoari ',
                            style: TextStyle(
                              fontFamily: 'AppleTP',
                              fontSize: 30.0,
                              color: Colors.white,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'project',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(5),
                        child: RichText(
                          text: TextSpan(
                            text: 'LICENSES',
                            recognizer: TapGestureRecognizer()..onTap = () {
                              _showLicense();
                            },
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),

                    ],
                  )),
              Expanded(
                flex: 2,
                child: new Column(children: <Widget>[
                  new CheckboxListTile(
                    value: _hiragana,
                    onChanged: (value) {
                      _hiraganaChanged(value);
                      __isButtonDisabledChanged();
                    },
                    title: new Text(
                      'Hiragana',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    subtitle: new Text(
                      'Include Hiragana syllabary',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    secondary: new Icon(
                      Icons.font_download,
                      color: Colors.white,
                    ),
                    activeColor: Colors.red,
                  ),
                  new CheckboxListTile(
                    value: _katakana,
                    onChanged: (value) {
                      _katakanaChanged(value);
                      __isButtonDisabledChanged();
                    },
                    title: new Text(
                      'Katakana',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    subtitle: new Text(
                      'Include Katakana syllabary',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    secondary: new Icon(
                      Icons.font_download,
                      color: Colors.white,
                    ),
                    activeColor: Colors.red,
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child: new RaisedButton(
                          padding: const EdgeInsets.all(8.0),
                          textColor: Colors.white,
                          color: Colors.red,
                          disabledColor: Colors.white,
                          onPressed: _isButtonDisabled
                              ? null
                              : () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new Party(
                                              h: _hiragana,
                                              k: _katakana,
                                            )),
                                  );
                                },
                          child: new Text(
                              _isButtonDisabled ? "Select one" : "Start"),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
