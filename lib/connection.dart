import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

StreamSubscription<DataConnectionStatus> listener;

checkInternet() async {
  print("The statement 'this machine is connected to the Internet' is: ");
  print(await DataConnectionChecker().hasConnection);
  // returns a bool

  // We can also get an enum value instead of a bool
  print("Current status: ${await DataConnectionChecker().connectionStatus}");
  // prints either DataConnectionStatus.connected
  // or DataConnectionStatus.disconnected

  // This returns the last results from the last call
  // to either hasConnection or connectionStatus
  print("Last results: ${DataConnectionChecker().lastTryResults}");

  // actively listen for status updates
  // this will cause DataConnectionChecker to check periodically
  // with the interval specified in DataConnectionChecker().checkInterval
  // until listener.cancel() is called
  listener = DataConnectionChecker().onStatusChange.listen((status) {
    switch (status) {
      case DataConnectionStatus.connected:
        print('Data connection is available.');
        break;
      case DataConnectionStatus.disconnected:
        print('You are disconnected from the internet.');
        break;
    }
  });
  await Future.delayed(Duration(seconds: 5));
  return (await DataConnectionChecker().connectionStatus);
}

checkConnection(BuildContext context) async {
  var status = await checkInternet();
//    var showToast = Fluttertoast.showToast(
//      msg: "Refreshing",
//      //textColor: Colors.blue,
//      toastLength: Toast.LENGTH_LONG,
//    );
  debugPrint("make request");
  if (status == DataConnectionStatus.disconnected) {
    showDialog(
//        barrierColor: ,
        context: context,
        barrierDismissible: false,
        useRootNavigator: true,
        builder: (context) {
          print("dialog");
          return CupertinoAlertDialog(
//              backgroundColor: Colors.w,
            title: Text("No Internet!"),
            content: Text('Connect to Internet and refresh.'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('Settings'),
                onPressed: () {
                  HapticFeedback.vibrate();
                  AppSettings.openWIFISettings();
                },
              ),
              CupertinoDialogAction(
                child: Text('Refresh'),
                onPressed: () {
                  print("clicked REFREHSEG");
                  HapticFeedback.vibrate();
                  Navigator.of(context).pop();
                  checkConnection(context);
                },
              )
            ],
          );
        });
  }
}
