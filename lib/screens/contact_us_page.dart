import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:novaji/screens/home_page.dart';
import 'package:novaji/screens/register_page.dart';
import 'package:novaji/services/authentication.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _recipientControlleer = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      'Contact Us',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.only(top: 12.0, bottom: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 2.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field cannot be empty';
                            }

                            return null;
                          },
                          controller: _subjectController,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                          decoration: const InputDecoration(
                              border: InputBorder.none, label: Text('Subject')),
                        ),
                      ),
                    ),
                    Container(
                      height: 120.0,
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.only(top: 12.0, bottom: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 2.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field cannot be empty';
                            }

                            return null;
                          },
                          controller: _bodyController,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                          decoration: const InputDecoration(
                              border: InputBorder.none, labelText: 'Body'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          final Email email = Email(
                            body: 'Email body',
                            subject: 'Email subject',
                            recipients: ['praiseajepe@gmail.com'],
                            cc: ['cc@example.com'],
                            bcc: ['bcc@example.com'],
                            attachmentPaths: [],
                            isHTML: false,
                          );

                          await FlutterEmailSender.send(email);

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
                              'Send Message',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22.0),
                            ))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
