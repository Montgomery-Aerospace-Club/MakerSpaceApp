import 'package:flutter/material.dart';
import 'package:themakerspace/src/widgets/appbar.dart';
import 'package:themakerspace/src/widgets/navbar.dart';

class BRs extends StatefulWidget {
  const BRs({super.key});

  @override
  State<BRs> createState() => _BRsState();
}

class _BRsState extends State<BRs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generateAppbar(title: "Borrow and Return", elevate: true),
      bottomNavigationBar: const Navbar(
        selectedIndex: 2,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
              )
            ],
          ))
          /*

Column(
                children: <Widget>[
                  TextFormField(
                      keyboardType: TextInputType.text,
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: "Enter your email",
                        enabledBorder: _inputformdeco(),
                        focusedBorder: _inputformdeco(),
                      )),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) async {
                      if (!_isLoading) {
                        _startLoading();
                      }
                      if (_selectedHighschool.id != 0 &&
                          passwordController.text != "" &&
                          usernameController.text != "") {
                        String finalSchool = "";
                        if (_selectedHighschool.id == 1) {
                          finalSchool = "Montgomery Highschool";
                        }
                        LoginConnection connection = await checkLoginConnection(
                            usernameController.text,
                            passwordController.text,
                            finalSchool);
                        if (connection.code == 200) {
                          writeEmailPassSchoolintoCookies(
                              usernameController.text,
                              passwordController.text,
                              finalSchool);
                          setState(() {
                            _isLoading = false;
                          });

                          if (await readFirstTime()) {
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              //MaterialPageRoute(builder: (context) => const MyLoginPage()),
                              MaterialPageRoute(
                                  builder: (context) => WelcomeScreen(
                                      email: usernameController.text,
                                      password: passwordController.text,
                                      school: finalSchool)),
                            );
                          } else {
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CoursesPage(
                                        email: usernameController.text,
                                        password: passwordController.text,
                                        school: finalSchool,
                                        refresh: true,
                                      )),
                            );
                          }
                        } else if (connection.code == 401) {
                          // ignore: use_build_context_synchronously
                          setState(() {
                            _isLoading = false;
                          });
                          // ignore: use_build_context_synchronously
                          showAlert(context);
                        }
                      } else {
                        setState(() {
                          _isLoading = false;
                        });
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Text(
                                "Please make sure you selected/filled out all the fields",
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        );
                      }
          */
        ],
      )),
    );
  }
}
