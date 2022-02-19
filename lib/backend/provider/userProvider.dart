// ignore_for_file: file_names

import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mill_10/backend/helper/AuthHelper.dart';
import 'package:mill_10/backend/helper/firestoreHelper.dart';
import 'package:mill_10/screens/Administration/admin.dart';
import 'package:mill_10/screens/Administration/bakery.dart';
import 'package:mill_10/screens/Administration/customerPage.dart';
import 'package:mill_10/screens/Administration/driver.dart';
import 'package:mill_10/screens/Administration/product.dart';
import 'package:mill_10/screens/Administration/supervisr.dart';
import 'package:mill_10/screens/Administration/times.dart';
import 'package:mill_10/screens/login.dart';
import 'package:mill_10/model/constantsName.dart';
import 'package:mill_10/model/user.dart';
import 'package:mill_10/service/user.dart';
import 'package:mill_10/utilities/router.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';
enum Status { loadedadmin,loadedemploye,loadedcostumer,unloaded,Uninitialized }

class UserProvider with ChangeNotifier {

  User currentUser;
  int typeGroup=0;
  String typeRole;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool loading=false;

  UserServices _userServices = UserServices();
  UserModel  selectedEmploye;
   String productUSerID;
  UserModel userModel;
  String errorMessage,message,editCustomerID;
  String role,customerID,employeeID,roleEdite;
  GlobalKey<FormState> scaffoldKey =GlobalKey<FormState>();
  GlobalKey<FormState> editEmployee =GlobalKey<FormState>();
  GlobalKey<FormState> formekey = GlobalKey<FormState>();
  GlobalKey<FormState> registerkey = GlobalKey<FormState>();
  GlobalKey<FormState> employkey = GlobalKey<FormState>();
  GlobalKey<FormState> customkey = GlobalKey<FormState>();
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController ytunus = TextEditingController();
  TextEditingController description = TextEditingController();



  getCurrentUser() async {
     currentUser = FirestoreHelper.firestoreHelper.getCurrentUserId();
    if (currentUser != null) {
      userModel = await FirestoreHelper.firestoreHelper.getUser(currentUser.uid);
      print("uuuuu is ${userModel.userid}");
    }
    notifyListeners();
    return userModel;
  }

  Future<UserModel> getUser(String userId) async {
    UserModel user = await FirestoreHelper.firestoreHelper.getUser(userId);
   await firestore.collection('users').doc(userId).get().then((value) {
        name.text =value.data()['name'];
        email.text =value.data()['email'];
        password.text =value.data()['passowrd'];
        phone.text =value.data()['phone'];
        address.text =value.data()['address'];
        description.text =value.data()['description'];
        ytunus.text =value.data()['ytunus'];
        typeGroup=(value.data()['group']=="A")?0:(value.data()['group']=="B")?1:2;
        print(typeGroup);
        });
    notifyListeners();
  }
  Future<UserModel> getUserEmploye(String userId) async {
    // UserModel user = await FirestoreHelper.firestoreHelper.getUser(userId);
    await firestore.collection('users').doc(userId).get().then((value) {
      name.text =value.data()['name'];
      email.text =value.data()['email'];
      password.text =value.data()['passowrd'];
      phone.text =value.data()['phone'];
      address.text =value.data()['address'];
      description.text =value.data()['description'];
      role=value.data()['role'];
    });
    notifyListeners();
  }









  Future<UserModel> signIn(BuildContext context) async {

    if (formekey.currentState.validate()) {
      formekey.currentState.save();
    try {
        User user = await AuthHelper.authHelper.login(email.text, passwordLogin.text);
        UserModel user2 = await FirestoreHelper.firestoreHelper.getUser(user.uid);
        print(' user id is ${user2.userid}');
        // UserModel user3= await  getUserID(user);
        print('User is ${user2.email}');
         getCurrentUser();
        if (user2.type == "admin") {
          print("email is ${user2.email}");
          AppRouter.router.pushToNewWidget(Admin());
        }
        if (user2.type == "costumer") {
          print("email is ${user2.email}");
          AppRouter.router.pushToNewWidget(CustomerProduct());
        }
        else if (user2.role == "Bakery") {
          print("email is ${user2.email}");
          AppRouter.router.pushToNewWidget(Bakery());
        }
        else if (user2.role == "Driver") {
          print("email is ${user2.email}");
          AppRouter.router.pushToNewWidget(Driver());
        }
        else if (user2.role == "Supervisor") {
          print("email is ${user2.email}");
          AppRouter.router.pushToNewWidget(Maincalend());
        }
        else if (user2.role == "collector") {
          print("email is ${user2.email}");
          AppRouter.router.pushToNewWidget(Entertime());
        }
      }catch (error) {
      // message=error.code;
      // return (error);
      errorMessage = error.toString();
      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(errorMessage,style: TextStyle(color: Colors.brown),),
      //     backgroundColor: Colors.brown[50],
      //   ),
      // );

      Fluttertoast.showToast(msg: errorMessage, textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM, backgroundColor: Colors.indigo);
    }
    // notifyListeners();
    }
  }

  Future<bool> signUpAdmin() async {
    if (registerkey.currentState.validate()) {
      registerkey.currentState.save();
      try {
        print("im in signup");
        await auth.createUserWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim())
            .then((result) async {
          _userServices.createAdmin(
            id: result.user.uid,
            email: email.text.trim(),
            password: password.text.trim(),
          );
          getUserById(result.user.uid);
        });
       AppRouter.router.pushToNewWidget(Login());
        return true;
      } catch (e) {
        print(e.toString());
        return false;
      }
    }
  }

 getUserById(String id) async {
    await firebaseFiretore.collection('users').doc(id).get().then((doc) {

     UserModel usermodel=   UserModel.fromDocumentSnapshot(doc);
     return usermodel;
    });
    notifyListeners();


  }


  Future signUpcostumer(BuildContext ctx) async {
    if (customkey.currentState.validate()) {
      customkey.currentState.save();
      try {
        await auth.createUserWithEmailAndPassword(email:email.text.trim(), password:password.text.trim())
            .then((result) async {
          _userServices.createCustomer(
            id: result.user.uid,
            name: name.text.trim(),
            password: password.text.trim(),
            email: email.text.trim(),
            phone: phone.text.trim(),
            address: address.text.trim(),
            description: description.text,
            ytunus: ytunus.text,
              group: (typeGroup == 0 ? "A" : typeGroup == 1 ? "B" : "C"),
          );
        });
        Fluttertoast.showToast(msg: "customer is added successfully", textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM, backgroundColor: Colors.indigo,
        );
         clearCustomer();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          var message=e.code;
          print(message);
          Scaffold.of(ctx).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Theme.of(ctx).errorColor,
            ),
          );

        }
      }
    }
    notifyListeners();
  }
  Future<UserModel> signUpemploye(BuildContext ctx) async {
    if (employkey.currentState.validate()) {
      employkey.currentState.save();
      try {
          await auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim())
            // ignore: missing_return
            .then((result) async {
       userModel= await _userServices.createemploye(
              role:role,
              id: result.user.uid,
              name: name.text,
              phone: phone.text,
              email: email.text,
              description: description.text,
              password:password.text,

          );
        });

          Fluttertoast.showToast(msg: "Employee is added successfully", textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM, backgroundColor: Colors.indigo,
          );
          clearCustomer();
        // return userModel;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          var message=e.code;
          print(message);
          Scaffold.of(ctx).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Theme.of(ctx).errorColor,
            ),
          );

        }
      }
    }

  }

  clearCustomer() {
    name.clear();
    phone.clear();
    email.clear();
    emailController.clear();
    passwordController.clear();
    description.clear();
    address.clear();
    password.clear();
    ytunus.clear();
    notifyListeners();
  }
  uploadimage(String linkimage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id= prefs.getString("id");
    _userServices.uploadimage(linkimage,id);
  }

  deletUser(String id) async{
    await firebaseFiretore.collection("users").doc(id).delete();
  }

  ///////////////////// for toggle  the kind ///////////////

  toggleGroup(int i) {
    this.typeGroup = i;
    notifyListeners();
  }

  toggleRole(String i) {
    this.typeRole = i;
    notifyListeners();
  }

//////////////////  Authentication For Login //////////////

  nullValidation(String value) {
    if (value.length == 0) {
      return 'Required field';
    }
  }

  emailValidation(String value) {
    if(value.isEmpty) {
      return 'Required Field';
    }else if (!isEmail(value)) {
      return 'Invalid Email syntax';
    }
    // else if(FirebaseAuthException (code:'email-already-in-use') != null ){
    //     return 'The account already exists for that email.';
    //   }
  }

  validatePassword(String value) {

    // Pattern pattern =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    // RegExp regex = new RegExp(pattern);
    // print(value);

    if (value.isEmpty || value.length == 0) {
      return 'Please enter password';
    }

    // else {
    //   switch (message) {
    //     case "ERROR_INVALID_EMAIL":
    //       errorMessage = "Your email address appears to be malformed.";
    //       break;
    //     case "ERROR_WRONG_PASSWORD":
    //       errorMessage = "Your password is wrong.";
    //       break;
    //     case "ERROR_USER_NOT_FOUND":
    //       errorMessage = "User with this email doesn't exist.";
    //       break;
    //     case "ERROR_USER_DISABLED":
    //       errorMessage = "User with this email has been disabled.";
    //       break;
    //     // case "ERROR_TOO_MANY_REQUESTS":
    //     //   errorMessage = "Too many requests. Try again later.";
    //     //   break;
    //     // case "ERROR_OPERATION_NOT_ALLOWED":
    //     //   errorMessage = "Signing in with Email and Password is not enabled.";
    //     //   break;
    //     // default:errorMessage = "An undefined Error happened.";
    //   }
    //   return errorMessage;
    //   // if (errorMessage != null) {
    //   //   return Future.error(errorMessage);
    //   // }
    //
    //   // if (!regex.hasMatch(value))
    //   //   return 'Enter valid password';
    //   // else
    //   //
    // }


  }

  validateRepeatedPassword(String value) {
    if (value != this.passwordController.text) {
      return 'the entered passwords are not matched';
    }
  }

//////////////////// logOut/////////////////////////////
  logout() async {
    this.currentUser = null;
    this.userModel = null;
    await FirebaseAuth.instance.signOut();
    emailController.clear();
    passwordController.clear();
    AppRouter.router.pushReplacementToNewWidget(Login());
  }

// _onStateChanged(User firebaseUser) async {
//   try {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString("id", firebaseUser.uid);
//       await _userServices.getUserById(user.uid).then((value) async {
//         userModel=value;
//         if(userModel.type=="admin"){
//           _status= Status.loadedadmin;
//           AppRouter.router.pushToNewWidget(Admin());
//         }else{ if(userModel.type=="costumer"){
//           _status= Status.loadedcostumer;
//           AppRouter.router.pushToNewWidget(Users());
//         }else{if(userModel.type=="employe"){
//           _status= Status.loadedemploye;
//         }}}
//         notifyListeners();
//
//      });
//     }catch(e){
//     print("$e");
//   }
//     notifyListeners();
//   }
// reloadUserModel(User firebaseUser) async {
//   _userModel = await _userServices.getUserById(firebaseUser.uid);
//   notifyListeners();
// }

  updateUserData({String userID}) async {
  if(scaffoldKey.currentState.validate()) {
    scaffoldKey.currentState.save();
  _userServices.updateUserProfile (
     id:userID,
    name: name.text,
    phone: phone.text,
    description: description.text,
    address: address.text,
    email: email.text,
    password: password.text,
    group:typeGroup == 0 ? "A" : typeGroup == 1 ? "B" : "C",
    ytunus: ytunus.text,
  );
    notifyListeners();
  }

}

   updateEmployeeData({String userID}) async {
  try {
    if(editEmployee.currentState.validate()) {
      editEmployee.currentState.save();
      _userServices.updateEmployeeProfile(
          id:userID,
          name: name.text,
          phone: phone.text,
          description: description.text,
          email: email.text,
          pass:password.text,
          role: role,
      );
    }
     notifyListeners();
  } on Exception catch (e) {
    print(e);
  }
}


}


