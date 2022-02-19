import 'package:flutter/material.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/screens/signUp.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:provider/provider.dart';




class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);
 @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

Widget _builEmail(TextEditingController emailController, BuildContext ctx) {
  return TextFormField(

      controller:emailController ,
      validator:(v)=>Provider.of<UserProvider>(ctx,listen: false).emailValidation(v),
      decoration: InputDecoration(
          labelText: "Email :",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          )));
}

Widget _builPassword(TextEditingController passController) {
  return TextFormField(

      controller:passController ,
      validator: (value) =>Provider.of<UserProvider>(context,listen: false).validatePassword(value),
      // value.isEmpty ? 'You must enter a valid password' : null,
      autocorrect: false,
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Password :",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          )));
}


Widget _translate() {
  return  Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
      
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed:  () {//translator.setNewLanguage(context, newLanguage: 'ar',restart: true,); 
            },
            child: const Text('Arabic',style: TextStyle( color: Colors.grey, ),),
              ),         
                      
                 
        
          const SizedBox(width:10),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {//translator.setNewLanguage(context, newLanguage: 'en',restart: true,);
            },
            child: const Text('English',style: TextStyle( color: Colors.grey, ),),
          ),
          const SizedBox(width:10),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {//translator.setNewLanguage(context, newLanguage: 'fi',restart: true,);
            },
            child: const Text('Suomi',style: TextStyle( color: Colors.grey, ),),
          ),
         ],
      );
                         
}


@override
  Widget build(BuildContext context,) {
  final auth= Provider.of<UserProvider>(context,listen:false);
  return Scaffold(
     backgroundColor: const Color(0xFF3E2723),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3E2723),
        title: const Text(
          'Mill Bakery',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18.0,
            color: Color(0xFFFFF3E0),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 82,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
              Positioned(
                  top: 75.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0)),
                      color: Color(0xFFFFF3E0),
                    ),
                    height: MediaQuery.of(context).size.height - 100,
                    width: MediaQuery.of(context).size.width,
                  )),
              Positioned(
                top: 30,
                left: (MediaQuery.of(context).size.width / 2) - 100,
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/login.png'),
                      )),
                ),
                height: 200,
                width: 200,
              ),
              Positioned(
                top: 250,
                left: 25,
                right: 25,
                child: Form(
                   key:auth.formekey,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: <Widget>[
                    
                      const SizedBox(height: 30),

                         _builEmail(auth.email,context),

                        const SizedBox(height: 20),

                         _builPassword(auth.passwordLogin),
                    const SizedBox(height: 30),

                         // Padding(
                         //   padding: const EdgeInsets.only(left: 250.0),
                         //   child: TextButton(
                         //     child: Text("SignUp",style: TextStyle(color: Colors.brown)),
                         //     onPressed: () { AppRouter.router.pushToNewWidget(SignUp()); },),
                         // ),
                        
                            ElevatedButton(
                             onPressed: ()  {
                               Provider.of<UserProvider>(context,listen:false).signIn(context);

                             },
                             child:const Text(
                               'log in',
                               textScaleFactor: 2,
                               style: TextStyle(
                                 fontSize: 15),
                             ),
                           style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF3E2723),
                            onPrimary: const Color(0xFFFFF3E0),
                            padding:const EdgeInsets.fromLTRB(20, 10, 20, 10)
                           ),
                           ),
                        
                      const SizedBox(height: 70),
                         _translate()
                       ],
                    ),
                    ),
             ),
        ],
      ),
      ],
    ),
    );
  }
}
                    

                          

                                        
                           
                           
                              
    
