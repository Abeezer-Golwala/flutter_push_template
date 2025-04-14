import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen(_firebaseForegroundMessageHandler);
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessageHandler);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundMessageHandler(
    RemoteMessage remoteMessage) async {
  await Firebase.initializeApp();

  CleverTapPlugin.createNotification(jsonEncode(remoteMessage.data));
  print("Clevertap firebase Processed Data: ${jsonEncode(remoteMessage.data)}");
}

/// Handles foreground messages of FCM
Future<void> _firebaseForegroundMessageHandler(
    RemoteMessage remoteMessage) async {
  if (remoteMessage.data.containsKey('wzrk_id')) {
    print('wzrk_id is present: ${remoteMessage.data['wzrk_id']}');
    CleverTapPlugin.createNotification(jsonEncode(remoteMessage.data));
  } else {
    print('wzrk_id is NOT present');
  }

  print("Clevertap firebase Processed Data: ${jsonEncode(remoteMessage.data)}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CleverTapPlugin _clevertapPlugin;
  @override
  void initState() {
    _clevertapPlugin = CleverTapPlugin();
    CleverTapPlugin.createNotificationChannel(
        "abtest", "abtest", "Flutter Test", 5, true);
    super.initState();
    CleverTapPlugin.initializeInbox();
    CleverTapPlugin.setDebugLevel(3);
    CleverTapPlugin.fetchWithMinimumIntervalInSeconds(0);
    CleverTapPlugin.getCleverTapID().then((value) {
      print("CleverTapID: $value");
    });
    _clevertapPlugin.setCleverTapProductConfigInitializedHandler(
        () => setState(() async {}));
    _clevertapPlugin
        .setCleverTapProductConfigFetchedHandler(() => setState(() async {
              await CleverTapPlugin.activate();
            }));

    _clevertapPlugin.setCleverTapProductConfigActivatedHandler(printpe);

    var pushPrimerJSON = {
      'inAppType': 'half-interstitial',
      'titleText': 'Get Notified',
      'messageText':
          'Please enable notifications on your device to use Push Notifications.',
      'followDeviceOrientation': false,
      'positiveBtnText': 'Allow',
      'negativeBtnText': 'Cancel',
      'fallbackToSettings': true,
      'backgroundColor': '#FFFFFF',
      'btnBorderColor': '#000000',
      'titleTextColor': '#000000',
      'messageTextColor': '#000000',
      'btnTextColor': '#000000',
      'btnBackgroundColor': '#FFFFFF',
      'btnBorderRadius': '4',
    };
    CleverTapPlugin.promptPushPrimer(pushPrimerJSON);
  }

  String textHolder = 'Old Sample Text...!!!';

  Future<void> changeText() async {
    var temp = {"": ""};
    CleverTapPlugin.recordEvent("abeezernativedisp", temp);
    setState(() async {
      //  List <dynamic> displayUnits = await CleverTapPlugin.getAllDisplayUnits();
      //    textHolder = "Display Units = "+displayUnits.toString();
      print("abezer test");
      List<dynamic>? myJSON = await CleverTapPlugin.getAllDisplayUnits();
      print("abezer $myJSON");

      // String nameString = jsonEncode(nameJson); // jsonEncode != .toString()

      // String jsonTags = jsonEncode(displayUnits);
      // var decodedJson = json.decode(jsonTags);
      // var jsonValue= json.decode(decodedJson['value']);
      //   print("Display Units = " + displayUnits.toString());
      //displayUnits.toString();
    });
    setState(() {
      textHolder = "Display Units";
    });
  }

  @override
  Widget build(BuildContext context) {
    printpe();
    // void onDisplayUnitsLoaded(List<dynamic> displayUnits) {
    //   this.setState(() async {
    //     List displayUnits = await CleverTapPlugin.getAllDisplayUnits();
    //     print("Display Units = " + displayUnits.toString());
    //     textHolder = displayUnits.toString();
    //   });
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: const Text("Performs onUserLogin"),
                  subtitle: const Text("Used to identify multiple profiles"),
                  onTap: onUserLogin,
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: const Text("Push Notification"),
                  subtitle: const Text("Pushes/Records an event"),
                  onTap: recordEvent,
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: const Text("App Inbox"),
                  subtitle: const Text("App Inbox event"),
                  onTap: printpe,
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: const Text("In App"),
                  subtitle: const Text("In App event"),
                  onTap: printpe,
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(textHolder, style: const TextStyle(fontSize: 21))),
            ElevatedButton(
              onPressed: () => changeText(),
              child: const Text(
                  'Click Here To Change Text Widget Text Dynamically'),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onUserLogin() {
    var stuff = ["bags", "shoes"];
    var profile = {
      'Name': 'Abeezer',
      //'Identity': '100',
      'Email': 'abeezer@flutter.com',
      'Phone': '+919799609447',
      'DOB': '01-01-1999',
      'stuff': stuff,
      'MSG-push': true,
      'MSG-whatsapp': true,
      'MSG-sms': true,
      'MSG-email': true
    };
    CleverTapPlugin.onUserLogin(profile);

    //showToast("onUserLogin called, check console for details");
  }

  void recordEvent() {
    var eventData = {'number': 1};
    CleverTapPlugin.recordEvent("AbeezerPushEvent", eventData);
  }

  void productConfigFetched() {
    print("Product Config Fetched");
    setState(() async {
      await CleverTapPlugin.activate();
    });
  }

  Future<void> printpe() async {
    var testkeyval = await CleverTapPlugin.getProductConfigString("testkey1");
    print("CleverTap testkey$testkeyval");
  }
}

CleverTapPlugin _clevertapPlugin = CleverTapPlugin();
_initializeCleverTap() async {
  await CleverTapPlugin.fetchAndActivate();
  _clevertapPlugin.setCleverTapProductConfigInitializedHandler(
    () async {
      await CleverTapPlugin.fetchWithMinimumIntervalInSeconds(0);
    },
  );
  _clevertapPlugin.setCleverTapProductConfigFetchedHandler(
    () async {
      await CleverTapPlugin.activate();
    },
  );
  _clevertapPlugin.setCleverTapProductConfigActivatedHandler(printpe);
}

void printpe() {
  print("RAJNSIH111 printpe");
}
