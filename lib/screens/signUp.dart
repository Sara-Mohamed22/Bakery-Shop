// // ignore_for_file: file_names
//
// import 'package:flutter/material.dart';
// import 'package:mill_10/backend/provider/userProvider.dart';
// import 'package:mill_10/utilities/router.dart';
// import 'package:provider/provider.dart';
//
//
//
//
// class SignUp extends StatefulWidget {
//  SignUp ({Key key}) : super(key: key);
//   @override
//   LoginState createState() => LoginState();
// }
//
// class LoginState extends State<SignUp > {
//
//   Widget _builEmail(TextEditingController emailController) {
//     return TextFormField(
//         controller:emailController ,
//         validator: (value) => value.isEmpty
//             ? 'You must enter a valid email'
//             : null,
//         decoration: InputDecoration(
//             labelText: "Email :",
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(50),
//             )));
//   }
//
//   Widget _builPassword(TextEditingController passController) {
//     return TextFormField(
//         controller:passController ,
//         validator: (value) => value.isEmpty ? 'You must enter a valid email' : null,
//         autocorrect: false,
//         obscureText: true,
//         decoration: InputDecoration(
//             labelText: "Password :",
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(50),
//             )));
//   }
//
//
//   @override
//   Widget build(BuildContext context,) {
//     final auth= Provider.of<UserProvider>(context,listen:false);
//     return Scaffold(
//       backgroundColor: const Color(0xFF3E2723),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF3E2723),
//         title: const Text(
//           'Mill Bakery',
//           style: TextStyle(
//             fontFamily: 'Montserrat',
//             fontSize: 18.0,
//             color: Color(0xFFFFF3E0),
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: [
//           Stack(
//             children: <Widget>[
//               Container(
//                 height: MediaQuery.of(context).size.height - 82,
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.transparent,
//               ),
//               Positioned(
//                   top: 75.0,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(45.0),
//                           topRight: Radius.circular(45.0)),
//                       color: Color(0xFFFFF3E0),
//                     ),
//                     height: MediaQuery.of(context).size.height - 100,
//                     width: MediaQuery.of(context).size.width,
//                   )),
//               Positioned(
//                 top: 30,
//                 left: (MediaQuery.of(context).size.width / 2) - 100,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/login.png'),
//                       )),
//                 ),
//                 height: 200,
//                 width: 200,
//               ),
//               Positioned(
//                 top: 250,
//                 left: 25,
//                 right: 25,
//                 child: Form(
//                   key: auth.registerkey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//
//                       const SizedBox(height: 30),
//
//                       _builEmail(auth.email),
//
//                       const SizedBox(height: 20),
//
//                       _builPassword(auth.password),
//
//
//                       // Padding(
//                       //   padding: const EdgeInsets.only(left: 250.0),
//                       //   child: TextButton(
//                       //     child: Text("SignUp",style: TextStyle(color: Colors.brown)),
//                       //     onPressed: () {  },),
//                       // ),
//                       SizedBox(height: 20,),
//                       Center(
//                         child: ElevatedButton(
//                           onPressed: ()  {
//                            auth.signUpAdmin();
//                           },
//
//                           child:const Text(
//                             'Sign Up',
//                             textScaleFactor: 2,
//                             style: TextStyle(
//                                 fontSize: 15),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                               primary: const Color(0xFF3E2723),
//                               onPrimary: const Color(0xFFFFF3E0),
//                               padding:const EdgeInsets.fromLTRB(20, 10, 20, 10)
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
