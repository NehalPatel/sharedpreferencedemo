import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreferencedemo/helpers/local_storage.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _sharedPreferenceTextValue = new TextEditingController();
  String _savedAccessToken = "";
  String _key = 'access_token';

  _loadAccessToken() async {
    setState(() {
      _savedAccessToken = LocalStorageService.getString(_key);

      print(_savedAccessToken);
    });
  }

  _saveAccessToken(String token) async {
    print("saving access token $token");
    LocalStorageService.setString(_key, token);

    _loadAccessToken();
  }

  @override
  void initState() {
    super.initState();
    LocalStorageService.init();
    _loadAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(13.4),
      alignment: Alignment.topCenter,
      child: Container(
        child: Column(
          children: [
            TextField(
              controller: _sharedPreferenceTextValue,
              decoration: InputDecoration(labelText: "Provide Access Token"),
            ),
            FlatButton(
              onPressed: () {
                _saveAccessToken(_sharedPreferenceTextValue.text);
                print(_savedAccessToken);
              },
              child: Text("Save Access Token"),
            ),
            Text("Saved Access Token : $_savedAccessToken")
          ],
        ),
      ),
    );
  }
}
