import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_login/flutter_login.dart';
import 'package:themakerspace/src/constants.dart';
import 'package:themakerspace/src/screens/home.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class Login extends StatelessWidget {
  const Login({super.key});

  Duration get loginTime => const Duration(milliseconds: 20);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
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

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: Constants.appName,
      // logo: const AssetImage('assets/images/ecorp-lightblue.png'),
      logo: const AssetImage("assets/images/schoollogo-nobg.png"),
      onLogin: _authUser,
      onSignup: _signupUser,
      userType: LoginUserType.name,
      messages: LoginMessages(
          userHint: "Enter Your Username", passwordHint: "Enter Your Password"),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Home(),
        ));
      },
      userValidator: _validateUser,
      hideForgotPasswordButton: true,
      onRecoverPassword: _recoverPassword,
    );
  }
}
