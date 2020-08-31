import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/presentation/block/ListData/dataList_bloc.dart';
import 'package:sample/presentation/block/auth/auth_bloc.dart';
import 'package:sample/presentation/block/image_picker/image_picker_bloc.dart';
import 'package:sample/presentation/pages/dashBoard.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class LoginPage extends StatelessWidget {
  String _email;
  String _password;
  bool _obscureText = true;
  // void _toggle() {
  //   setState(() {
  //     _obscureText = !_obscureText;
  //   });
  // }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = new TextEditingController(text: "admins@gmail.com");
  final passwordController = new TextEditingController(text: "password");
  Widget _buildEmail() {
    return TextFormField(
      controller: emailController,
      // initialValue: "ebin_es@yahoo.com",
      // decoration: InputDecoration(labelText: 'Email'),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      obscureText: _obscureText,
      controller: passwordController,
      // initialValue: "76676744@aA",
      // decoration: InputDecoration(labelText: 'Password'),
      decoration: InputDecoration(

          // suffixIcon: FlatButton(
          //     onPressed: _toggle,
          //     child: new Text(
          //       _obscureText ? "Show" : "Hide",
          //       style: TextStyle(color: Colors.green),
          //     )),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
        BlocProvider<DataListBloc>(
          create: (BuildContext context) => DataListBloc(),
        )
      ],
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstrains) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstrains.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 155.0,
                        child: Center(
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      _buildEmail(),
                      SizedBox(
                        height: 25.0,
                      ),
                      _buildPassword(),
                      SizedBox(
                        height: 30.0,
                      ),
                      // Builder(builder: (BuildContext context) {
                      //   return
                      loginButton(),

                      SizedBox(
                        height: 25.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget loginButton() {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, state) {
      // ignore: close_sinks
      final authBloc = context.bloc<AuthBloc>();
      return Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.green,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            if (!_formKey.currentState.validate()) {
              return;
            }

            _formKey.currentState.save();

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MultiBlocProvider(providers: [
                          BlocProvider<ImagePickerBloc>(
                              create: (BuildContext context) =>
                                  ImagePickerBloc()),
                          BlocProvider<DataListBloc>(
                            create: (BuildContext context) => DataListBloc(),
                          )
                        ], child: DashBoardPage())));

            print(_email);
            print(_password);
          },
          child: Text("Log In",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      );
    });
  }
}
