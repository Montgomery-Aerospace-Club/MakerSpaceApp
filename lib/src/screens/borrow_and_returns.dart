import 'package:flutter/material.dart';
import 'package:themakerspace/src/widgets/appbar.dart';
import 'package:themakerspace/src/widgets/navbar.dart';

class BRs extends StatefulWidget {
  const BRs({super.key});

  @override
  State<BRs> createState() => _BRsState();
}

class _BRsState extends State<BRs> {
  final idController = TextEditingController();
  bool forAnotherPeron = false;

  @override
  void dispose() {
    idController.dispose();
    super.dispose();
  }

  OutlineInputBorder _inputformdeco() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(
          width: 1.5, color: Colors.blue, style: BorderStyle.solid),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generateAppbar(title: "Borrow and Return", elevate: true),
      bottomNavigationBar: const Navbar(
        selectedIndex: 2,
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  // Text(
                  //   "Option 1 - Barcode",
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .displaySmall
                  //       ?.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 6,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: idController,
                            decoration: InputDecoration(
                              labelText: "Component ID",
                              hintText: "Scan the barcode",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.3),
                            ),
                          )),
                      Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Is this for another person?",
                                    textAlign: TextAlign.center,
                                  ),
                                  Checkbox(
                                      value: forAnotherPeron,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          forAnotherPeron = value ?? false;
                                        });
                                      }),
                                ],
                              ))),
                    ],
                  ),

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
              ))),
    );
  }
}
