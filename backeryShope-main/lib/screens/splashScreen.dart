// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mill_10/backend/helper/firestoreHelper.dart';
import 'package:mill_10/backend/provider/adminProvider.dart';
import 'package:mill_10/backend/provider/eventsProvider.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/screens/Administration/admin.dart';
import 'package:mill_10/screens/Administration/bakery.dart';
import 'package:mill_10/screens/drop.dart';
import 'package:mill_10/screens/login.dart';
import 'package:mill_10/model/product.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  @override
  void initState() {
    Provider.of<AdminProvider>(context, listen: false).getCategories(); 
    Provider.of<AdminProvider>(context, listen: false).getproduct();
    Provider.of<EventsProvider>(context, listen: false).getEvents();
    super.initState();
  }


  Widget build(BuildContext context) {
    Provider.of<AdminProvider>(context, listen: false).getCategories();
    Provider.of<AdminProvider>(context, listen: false).getproduct();

    return Login();
  }
}
