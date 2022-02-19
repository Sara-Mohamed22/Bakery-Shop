
import 'package:flutter/material.dart';
import 'package:mill_10/model/orderModel.dart';
import 'package:mill_10/model/user.dart';

class AppRouter {
  AppRouter._();
  static AppRouter router = AppRouter._();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  pushToNewWidget(Widget widget) {
    navigatorKey.currentState.push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  popPage() {
    navigatorKey.currentState.pop();
  }


  pushReplacementToNewWidget(Widget widget) {
    navigatorKey.currentState.pushReplacement(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}



class Globals {
  Globals._();
  static Globals globals = Globals._();
  UserModel userModel;
  OrderModel orderModel;
}