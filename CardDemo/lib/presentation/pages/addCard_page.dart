import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:sample/mock/models/cardModel.dart';
import 'package:sample/mock/widgets/datePicker.dart';
import 'package:sample/presentation/block/ListData/dataList_bloc.dart';

class AddCardPage extends StatefulWidget {
  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = new TextEditingController();
  final cardController = new TextEditingController();
  final numberController = new TextEditingController();
  static DateTime now = DateTime.now();
  String dateSelected;
  @override
  Widget build(BuildContext context) {
    dateSelected = '$now.toLocal()'.split(
          '-',
        )[1] +
        '  $now.toLocal()'.split(
          '-',
        )[0];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        // autovalidate: true,
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildName(context),
            SizedBox(
              height: 25.0,
            ),
            _buildCardName(context),
            SizedBox(
              height: 25.0,
            ),
            _buildNumber(),
            SizedBox(
              height: 25.0,
            ),
            DatePicker((value) {
              dateSelected = value;
            }),
            SizedBox(
              height: 25.0,
            ),
            BlocProvider<DataListBloc>(
              create: (BuildContext context) => DataListBloc(),
              child: saveButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return BlocListener(
        cubit: BlocProvider.of<DataListBloc>(context),
        listener: (context, state) {},
        child: BlocBuilder<DataListBloc, DataListState>(
            cubit: BlocProvider.of<DataListBloc>(context),
            builder: (context, state) {
              final dataBloc = BlocProvider.of<DataListBloc>(context);
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
                    dataBloc.add(AddDataEvent(CardModel(
                        nameController.text,
                        cardController.text,
                        numberController.text,
                        dateSelected)));
                    Fluttertoast.showToast(
                        msg: "New Card Created",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: Text("Add Card",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              );
            }));
  }

  Widget _buildName(context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            // enabled: _nameEnable,
            // obscureText: _obscureText,
            controller: nameController,
            // initialValue: "76676744@aA",
            // decoration: InputDecoration(labelText: 'Password'),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Card Holder",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
            keyboardType: TextInputType.name,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Name is Required';
              }

              return null;
            },
            onSaved: (String value) {
              // _name = value;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCardName(context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            // enabled: _nameEnable,
            // obscureText: _obscureText,
            controller: cardController,
            // initialValue: "76676744@aA",
            // decoration: InputDecoration(labelText: 'Password'),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Name of Card",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
            keyboardType: TextInputType.name,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Card Name is Required';
              }

              return null;
            },
            onSaved: (String value) {
              // _name = value;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNumber() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            // obscureText: _obscureText,
            // enabled: _numberEnable,
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
                hintText: "Card Number",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
            keyboardType: TextInputType.phone,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Card Number is Required';
              }
              if (value.length < 5) {
                return 'Card Number must be min 5 digit';
              }

              return null;
            },
            onSaved: (String value) {
              // _number = value;
            },
          ),
        ),
      ],
    );
  }
}
