import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_login/flutter_login.dart';
import 'package:themakerspace/src/constants.dart';
import 'package:themakerspace/src/providers/api.dart';
import 'package:themakerspace/src/screens/home.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class Login extends StatelessWidget {
  const Login({super.key});

  Future<String?> _authUser(LoginData data) {
    //   debugPrint('Name: ${data.name}, Password: ${data.password}');

    return login(data.name, data.password).then((bool value) {
      if (value) {
        return null;
      } else {
        return "Unable to log in with provided credentials.";
      }
    });
  }

  Future<String?> _signupUser(SignupData data) {
    //debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(const Duration(milliseconds: 10))
        .then((value) => "We are currently not accepting sign ups, sorry.");
    // return Future.delayed(const Duration(milliseconds: 350)).then((value) =>
    //     register(
    //             data.name ?? "",
    //             data.password ?? "",
    //             data.additionalSignupData?["email"] ?? "",
    //             data.additionalSignupData?["user_id"] ?? "")
    //         .then((value) {
    //       if (value.isEmpty) {
    //         return null;
    //       }
    //       return value;
    //     }));
  }

  String? _validateUser(String? username) {
    if (username == null) {
      return "Please enter a username";
    }
    if (username.length <= 3) {
      return "Username too short";
    }
    return null;
  }

  String? numberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a student id";
    }
    if (value.length < 6) {
      return '"$value" is not a valid student id';
    }
    final n = int.tryParse(value);
    if (n == null) {
      return '"$value" is not a valid student id';
    }
    return null;
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: Constants.appName,
      // logo: const AssetImage('assets/images/ecorp-lightblue.png'),
      logo: const AssetImage("assets/images/schoollogo-nobg.png"),
      onLogin: _authUser,
      onSignup: _signupUser,
      // additionalSignupFields: [
      //   UserFormField(
      //       keyName: "email",
      //       displayName: "Enter Your Email",
      //       fieldValidator: validateEmail,
      //       icon: const Icon(Icons.email),
      //       userType: LoginUserType.email),
      //   UserFormField(
      //       keyName: "user_id",
      //       displayName: "Enter Your Student ID",
      //       fieldValidator: numberValidator,
      //       icon: const Icon(Icons.numbers),
      //       userType: LoginUserType.text)
      // ],
      userType: LoginUserType.name,
      messages: LoginMessages(
        userHint: "Enter Your Username",
        passwordHint: "Enter Your Password",
        signUpSuccess: "Welcome to the Maker Space 🔨",
      ),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Home(),
        ));
      },
      userValidator: _validateUser,
      hideForgotPasswordButton: true,
      onRecoverPassword: (_) {
        return null;
      },
    );
  }
}
