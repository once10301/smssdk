import 'package:flutter/material.dart';
import 'package:smssdk/smssdk.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var phone = '', code = '';

  @override
  void initState() {
    Smssdk.init("2a87330c459a8", "f1509b680c66f561bf1519e891c200d3");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 100.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
              onChanged: (v) {
                phone = v;
              },
            ),
          ),
          MaterialButton(
            onPressed: () => getCode(context),
            color: Colors.blueAccent,
            child: Text('getCode'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 100.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Code'),
              keyboardType: TextInputType.number,
              onChanged: (v) {
                code = v;
              },
            ),
          ),
          MaterialButton(
            onPressed: () => submitCode(context),
            color: Colors.blueAccent,
            child: Text('submitCode'),
          ),
        ],
      ),
    );
  }

  void getCode(BuildContext context) async {
    var get = await Smssdk.getCode(phone);
    showAlert(get.status, get.msg, context);
  }

  void submitCode(BuildContext context) async {
    var submit = await Smssdk.submitCode(phone, code);
    showAlert(submit.status, submit.msg, context);
  }

  void showAlert(int status, String msg, BuildContext context) {
    String title = "失败";
    switch (status) {
      case 0:
        title = "成功";
        break;
      case 1:
        title = "失败";
        break;
      default:
        title = status.toString();
        break;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
