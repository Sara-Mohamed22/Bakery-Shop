import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mill_10/backend/provider/eventsProvider.dart';
import 'package:mill_10/backend/provider/imagepicker.dart';
import 'package:mill_10/backend/provider/adminProvider.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/screens/splashScreen.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:provider/provider.dart';




void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
  MultiProvider(providers:
    [
      ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider(),
       ),
      ChangeNotifierProvider<AdminProvider>(create: (_) =>AdminProvider()
      ),
     ChangeNotifierProvider<UploadImageProvider>(create: (context) => UploadImageProvider.nodata(),
       ),
      ChangeNotifierProvider<EventsProvider>(create: (context) => EventsProvider(),
      ),
    ],

     child:  MaterialApp(
       home: MyApp(),
       navigatorKey: AppRouter.router.navigatorKey,
       debugShowCheckedModeBanner: false,
  )));
}



class  MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    final Future<FirebaseApp> initialization = Firebase.initializeApp();
    return FutureBuilder(

      future:initialization ,
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Something went wrong")],
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          //   auth.status=Status.Unauthenticated;
          // print("status main => ${auth.status}");
          // switch (auth.status) {
          //
          //   case Status.loadedadmin:
          //     return Admin();
          //   case Status.unloaded:
          //     return Login();
          //   default:
              return SplashScreen();
          }


        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()],
          ),
        );
      },
    );
  }
}
