import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SecurityPage extends StatefulWidget {
  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = new TextEditingController(text: "admins@gmail.com");
  final passwordController = new TextEditingController(text: "password");
  final nameController = new TextEditingController(text: "Admin");
  final numberController = new TextEditingController(text: "+91 9495089097");
  String _email = "admins@gmail.com";
  String _name = "Admin";
  String _number = "+91 9495089097";
  String _password = "password";
  bool _nameEnable = false;
  bool _emailEnable = false;
  bool _numberEnable = false;
  bool _passwordEnable = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        autovalidate: true,
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildName(context),
            SizedBox(
              height: 25.0,
            ),
            _buildEmail(),
            SizedBox(
              height: 25.0,
            ),
            _buildNumber(),
            SizedBox(
              height: 25.0,
            ),
            _buildPassword(),
            SizedBox(
              height: 25.0,
            ),
            saveButton(),
            SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.green,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (!_formKey.currentState.validate()) {
            Fluttertoast.showToast(
                msg: "Field must be Validated",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return;
          }

          _formKey.currentState.save();
          Fluttertoast.showToast(
              msg: "Changes Saved",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

          print(_email);
          print(_password);
        },
        child: Text("Save changes",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildName(context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            enabled: _nameEnable,
            // obscureText: _obscureText,
            controller: nameController,
            // initialValue: "76676744@aA",
            // decoration: InputDecoration(labelText: 'Password'),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
            //keyboardType: TextInputType.name,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Name is Required';
              }

              return null;
            },
            onSaved: (String value) {
              _name = value;
            },
          ),
        ),
        _nameEnable
            ? IconButton(
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    _nameEnable = false;
                  });
                })
            : IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    _nameEnable = true;
                  });
                }),
      ],
    );
  }

  Widget _buildNumber() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            // obscureText: _obscureText,
            enabled: _numberEnable,
            controller: numberController,
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
                hintText: "Mobile Number",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
            keyboardType: TextInputType.phone,
            validator: (String value) {
              if (value.isEmpty) {
                return 'mobile Number is Required';
              }

              return null;
            },
            onSaved: (String value) {
              _number = value;
            },
          ),
        ),
        _numberEnable
            ? IconButton(
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    _numberEnable = false;
                  });
                })
            : IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    _numberEnable = true;
                  });
                }),
      ],
    );
  }

  Widget _buildEmail() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: emailController,
            enabled: _emailEnable,
            // initialValue: "ebin_es@yahoo.com",
            // decoration: InputDecoration(labelText: 'Email'),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
            keyboardType: TextInputType.emailAddress,
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
          ),
        ),
        _emailEnable
            ? IconButton(
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    _emailEnable = false;
                  });
                })
            : IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    _emailEnable = true;
                  });
                }),
      ],
    );
  }

  Widget _buildPassword() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            enabled: _passwordEnable,
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
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
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
          ),
        ),
        _passwordEnable
            ? IconButton(
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    _passwordEnable = false;
                    _obscureText = true;
                  });
                })
            : IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    _passwordEnable = true;
                    _obscureText = false;
                  });
                }),
      ],
    );
  }
}
