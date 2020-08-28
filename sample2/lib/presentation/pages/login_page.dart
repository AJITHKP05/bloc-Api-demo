import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/block/auth/auth_bloc.dart';
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
  final emailController = new TextEditingController(text: "ebin_es@yahoo.com");
  final passwordController = new TextEditingController(text: "76676744@aA");
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
    return BlocProvider(
      create: (BuildContext context) => AuthBloc(),
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
                      Builder(
                        builder: (BuildContext context) => BlocListener(
                          cubit: BlocProvider.of<AuthBloc>(context),
                          listener: (BuildContext context, state) {
                            if (state is LoggedState) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DashBoardPage(state.name)));
                            }
                          },
                          child: BlocBuilder<AuthBloc, AuthState>(
                              cubit: BlocProvider.of<AuthBloc>(context),
                              builder: (BuildContext context, state) {
                                // ignore: unused_local_variable
                                // ignore: close_sinks
                                // final authBloc = context.bloc<AuthBloc>();
                                return state is NoInternetState
                                    ? Column(
                                        children: [
                                          Text("please connect to internet"),
                                          loginButton()
                                        ],
                                      )
                                    : state is NotLoggedInState
                                        ? loginButton()
                                        : state is LoggingState
                                            ? SizedBox(
                                                height: 35,
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : state is LoggedState
                                                ? loginButton()
                                                : state is LoggedFailedState
                                                    ? Column(
                                                        children: [
                                                          Text(
                                                              "user name or password is incorrect "),
                                                          loginButton()
                                                        ],
                                                      )
                                                    : SizedBox(
                                                        height: 35,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                              }),
                        ),
                      ),
                      // }),
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
            authBloc.add(LoggingEvent("$_email", "$_password"));

            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => DashBoardPage()));

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

  Widget view(BuildContext context, na) {
    // String na = await getName();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DashBoardPage(na)));

    return Text("$na");
  }

  // Future getName() async {
  //   SharedPreferences shared = await SharedPreferences.getInstance();
  //   String na = shared.getString("name");
  //   return na;
  // }
}
