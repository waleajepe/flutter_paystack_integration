import 'package:flutter/material.dart';
import 'package:novaji/screens/home_page.dart';
import 'package:novaji/screens/register_page.dart';
import 'package:novaji/services/authentication.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailControlleer = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child:
            Form(
              key: _formKey,
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  'Login User',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: const EdgeInsets.only(top: 12.0, bottom: 10.0),
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 2.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        }

                        return null;
                      },
                      controller: _emailControlleer,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                      decoration: const InputDecoration(
                          border: InputBorder.none, label: Text('Enter email')),
                    ),
                  ),
                ),
                Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: const EdgeInsets.only(top: 12.0, bottom: 10.0),
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 2.0),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        }

                        return null;
                      },
                      controller: _passwordController,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                      decoration: const InputDecoration(
                          border: InputBorder.none, labelText: 'Enter password'),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      Authentication.signInUser(email: _emailControlleer.text, password: _passwordController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const HomePage();
                          },
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 60.0,
                    margin: const EdgeInsets.only(top: 25.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        border: Border.all(color: Colors.black)),
                    child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 2.0),
                        child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22.0),
                            ))),
                  ),
                ),
                TextButton(
                   onPressed: () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (BuildContext context) {
                           return const Registration();
                         },
                       ),
                     );
                   },
                   child: Text('Dont\'t have an account?'),
                )

              ],

              ),
            ),
          ),


        ),
      ),
    );
  }
}

