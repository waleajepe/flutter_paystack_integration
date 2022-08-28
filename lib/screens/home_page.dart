import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:novaji/data.dart';
import 'package:novaji/screens/checkout.dart';
import 'package:novaji/screens/register_page.dart';

import 'contact_us_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          // leading: IconButton(
          //   icon: const Icon(Icons.view_headline),
          //   onPressed: () {},
          // ),
          title: const Text('Galago'),
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Products',
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.w500),
                  ),
                  ListView.builder(
                      padding:
                          const EdgeInsets.only(top: 25, right: 25, left: 25),
                      itemCount: products.length,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CheckOut(product: products[index])));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black12),
                            ),
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 110,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.black12),
                                      image: DecorationImage(
                                          image:
                                              AssetImage(products[index].image),
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(height: 14.0),
                                    Text(products[index].name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black45,
                                        )),
                                    const SizedBox(height: 5.0),
                                    Text('Author: ' + products[index].shop,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black45,
                                        )),
                                    Text(
                                        'Price: ' +
                                            '\$' +
                                            products[index].price,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black45,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Galago\'s Store',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          color: Colors.white),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      currentUser!.email.toString(),
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              ListTile(
                title: const Text('Products list'),
                leading: const Icon(Icons.storefront_outlined),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Contact us'),
                leading: const Icon(Icons.contact_mail),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Contact();
                  }));
                },
              ),
              ListTile(
                title: const Text('About Us'),
                leading: const Icon(Icons.account_box_outlined),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Sign out'),
                leading: const Icon(Icons.outbond_outlined),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Login();
                  }));
                },
              ),
            ],
          ),
        ));
  }
}
