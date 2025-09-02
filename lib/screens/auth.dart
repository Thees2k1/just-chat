import 'package:flutter/material.dart';
import 'package:just_chat/constants/common.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
    bool isLogin = true;
    String email = '';
    String password = '';
    final formKey = GlobalKey<FormState>();

  void submit(){
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      print('Email: $email, Password: $password, isLogin: $isLogin');
    };
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(24),
                alignment: Alignment.center,
                width: 240,
                height: 240,
                child: Image.asset(Assets.chatImage, fit: BoxFit.cover),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email Address: ",
                              hintText: "Enter your email address"
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value){
                              if( value == null || value.isEmpty || !value.contains('@')){
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onSaved: (value){
                              email = value!;
                            },
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password: ",
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty || value.length < 6) {
                                return 'Please enter a valid password (min. 6 characters)';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              password = value!;
                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer,
                ),
                child: Text(isLogin == true ? "Login" : "Signup"),
              ),
              TextButton(
                onPressed: () => setState(() {
                  isLogin = !isLogin;
                }),
                style: TextButton.styleFrom(textStyle: TextStyle(
                  color: Colors.white,
                )),
                child: Text(
                  isLogin == true
                      ? 'Create new account'
                      : 'Already have an account',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
