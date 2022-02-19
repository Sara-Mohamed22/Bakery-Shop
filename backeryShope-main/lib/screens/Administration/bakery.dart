// ignore_for_file: missing_return, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mill_10/backend/helper/firestoreHelper.dart';
import 'package:mill_10/backend/provider/adminProvider.dart';
import 'package:mill_10/model/orderModel.dart';
import 'package:mill_10/model/product.dart';
import 'package:mill_10/screens/drop.dart';
import 'package:mill_10/utilities/router.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class Bakery extends StatefulWidget {
  const Bakery({Key key}) : super(key: key);

  @override
  _BakeryState createState() => _BakeryState();
}

class _BakeryState extends State<Bakery> {
  String groupCount, idProduct;

  // String dropdownValue = '';
  bool shouldEnable = false;
  ProductModel selectProduct;
  bool dropDown;
  var _category;
  int divider = 0 , sum =0 ;


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminProvider>(context, listen: false);

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 60,
              backgroundColor: const Color(0xFF3E2723),
              title: const Text(
                "Bakery",
                style: TextStyle(
                  color: Color(0xFFFFF3E0),
                ),
              ),
              leading: IconButton(
                color: const Color(0xFFFFF3E0),
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  AppRouter.router.popPage();
                },
              ),
              centerTitle: true,
            ),
            body: Scaffold(
              backgroundColor: const Color(0xFFFFF3E0),
              body: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('product').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      return ListView(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 90,
                                margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                                child: Selector<AdminProvider, int>(builder: (context, value, widget) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.all(10),
                                          width: 40,
                                          decoration: BoxDecoration(color: Colors.brown.withOpacity(0.4), borderRadius: BorderRadius.circular(50)),
                                          child: RadioListTile(
                                              title: const Text(
                                                'A',
                                                style: TextStyle(color: Colors.brown, fontSize: 18, fontWeight: FontWeight.bold),
                                              ),
                                              value: 0,
                                              groupValue: value,
                                              onChanged: (v) {
                                                setState(() {
                                                  provider.toggleGroup(v);
                                                  provider.group = value;
                                                  provider.gruopName = 'A';
                                                });
                                              }),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        margin: const EdgeInsets.all(10),
                                        width: 40,
                                        decoration: BoxDecoration(color: Colors.brown.withOpacity(0.4), borderRadius: BorderRadius.circular(50)),
                                        child: RadioListTile(
                                            title: const Text('B'),
                                            value: 1,
                                            groupValue: value,
                                            onChanged: (v) {
                                              setState(() {
                                                provider.toggleGroup(v);
                                                provider.group = value;
                                                provider.gruopName = 'B';
                                              });

                                              print('vvvvv is ${value}');
                                            }),
                                      )),
                                      Expanded(
                                          child: Container(
                                        margin: EdgeInsets.all(10),
                                        width: 40,
                                        decoration: BoxDecoration(color: Colors.brown.withOpacity(0.4), borderRadius: BorderRadius.circular(50)),
                                        child: RadioListTile(
                                            title: Text('C'),
                                            value: 2,
                                            groupValue: value,
                                            onChanged: (v) {
                                              setState(() {
                                                provider.toggleGroup(v);
                                                provider.group = value;
                                                provider.gruopName = 'C';
                                              });

                                              print("tttttt${provider.group}");
                                            }),
                                      )),
                                    ],
                                  );
                                }, selector: (context, provider) {
                                  return provider.typeGroup;
                                }),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFF3E2723),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection('product').snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        return Container(
                                          child: InputDecorator(
                                            decoration: const InputDecoration(
                                              //labelText: 'Activity',
                                              hintText: ' Choose an Product',
                                              hintStyle: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            isEmpty: _category == null,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                value: _category,
                                                isDense: true,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _category = newValue;
                                                    dropDown = false;
                                                    print(_category);
                                                  });
                                                  provider.dropdownValue = _category;
                                                  //  print(newValue.productname);
                                                  // dropdownValue = newValue.productname;
                                                  // provider.idProduct =snapshot.data.docs[''];
                                                },
                                                items: snapshot.data?.docs.map((DocumentSnapshot document) {
                                                  ProductModel model = ProductModel.toMap(document);
                                                  provider.idProduct = model.idproduct;
                                                  // provider.dropdownValue=model.productname;
                                                  return new DropdownMenuItem<String>(
                                                    value: model.productname,
                                                    child: Text(
                                                      " ${model.productname}",
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                  height: 90,
                                  width: 400,
                                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFF3E2723),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12)),

                                  // <QuerySnapshot>
                                  child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('orders')
                                          .where('groupName', isEqualTo: provider.gruopName)
                                          .where('status', whereIn: [orderStatus.preparing.name , orderStatus.confirmed.name])
                                          //.where('status', isEqualTo: orderStatus.confirmed.name)

                                          .where('productname', isEqualTo: provider.dropdownValue)
                                          .snapshots(),
                                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        print(provider.dropdownValue);
                                        print("fffffffffffffff ${provider.gruopName}");
                                        if (!snapshot.hasData) {
                                          return CircularProgressIndicator();
                                        } else {
                                          List ds = snapshot.data?.docs ?? [];

                                          provider.docs = snapshot.data?.docs;
                                          provider.total = 0;

                                          for (int i = 0; i < ds.length; i++) {
                                            // if (!ds[i]['backeryFinish'])
                                            provider.total += toInt(ds[i]['quantity'] ?? 0);
                                            sum =provider.total ;
                                            print('providerTot ${provider.total}');
                                          }

                                          if (provider.num != 0) {
                                            divider = provider.total ~/ provider.num;
                                          }
                                          print('divider $divider');
                                          return Container(
                                            width: 250,
                                            height: 150,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Total of group ${provider.gruopName} for product is ${provider.total }",
                                                    style: const TextStyle(fontFamily: 'Montserrat', fontSize: 18.0, fontWeight: FontWeight.bold)),
                                                Text(
                                                    divider == 0
                                                        ? 'please enter the number'
                                                        : "Total to do is $divider for group ${provider.gruopName}",
                                                    style: const TextStyle(fontFamily: 'Montserrat', fontSize: 18.0, fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          );
                                        }
                                      })),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 60,
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: ElevatedButton(
                                      onPressed: ()async {
                                final response =    await   FirebaseFirestore.instance
                                            .collection('orders')
                                            .where('groupName', isEqualTo: provider.gruopName)
                                            .where('status', isEqualTo: orderStatus.confirmed.name)

                                           .where('productname', isEqualTo: provider.dropdownValue).get();


                                              final batch = FirebaseFirestore.instance.batch();
                                              response.docs.forEach((doc)
                                              {
                                              final docRef = FirebaseFirestore.instance.collection('orders').doc(doc.id);
                                                  batch.update(docRef, {'status' : orderStatus.preparing.name}) ;
                                              });

                                            await  batch.commit();


                                        if (provider.total == 0) {
                                          Fluttertoast.showToast(
                                              msg: "there's no product to prepare",
                                              textColor: Colors.white,
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.indigo);
                                                                                }
                                               else {
                                            OrderModel model = OrderModel(
                                            orderId: idProduct,
                                            quantity: provider.total.toString(),
                                            groupName: provider.gruopName,
                                            groupCount: groupCount,
                                            productname: provider.dropdownValue,
                                            );
                                            Provider.of<AdminProvider>(context, listen: false).startBackery(model);

                                            setState(() {
                                              shouldEnable = true;
                                            });
                                            }} ,






                                      child: const Text(
                                        'Start',
                                        textScaleFactor: 2,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: const Color(0xFF3E2723),
                                          onPrimary: const Color(0xFFFFF3E0),
                                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 5)),
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   width: 20,
                                  // ),
                                  Spacer(),
                                  Container(
                                    height: 60,
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (shouldEnable) {
                                          shouldEnable = false;
                                          OrderModel model = OrderModel(
                                            orderId: idProduct,
                                            quantity: provider.total.toString(),
                                            groupName: provider.gruopName,
                                            groupCount: groupCount,
                                            productname: provider.dropdownValue,
                                          );
                                          Provider.of<AdminProvider>(context, listen: false).stopBackery(model);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "must click start before",
                                              textColor: Colors.white,
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.indigo);
                                        }


                                      },
                                      child: const Text(
                                        'Stop',
                                        textScaleFactor: 2,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: const Color(0xFF3E2723),
                                          onPrimary: const Color(0xFFFFF3E0),
                                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 5)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  }),
            )));
  }
}
