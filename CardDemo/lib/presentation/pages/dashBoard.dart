import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample/mock/models/cardModel.dart';
import 'package:sample/mock/widgets/dropDown_Language.dart';
import 'package:sample/presentation/block/ListData/dataList_bloc.dart';
import 'package:sample/presentation/block/image_picker/image_picker_bloc.dart';
import 'package:sample/presentation/pages/Security.dart';
import 'package:sample/presentation/pages/addCard_page.dart';

class DashBoardPage extends StatelessWidget {
  bool imageHolder = false;
  File _image;

  @override
  Widget build(BuildContext context) {
    List<CardModel> list;
    return Scaffold(
        // backgroundColor: Colors.,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Profile",
            style: TextStyle(
                fontSize: 20,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  " Prefered Language",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: DropDownLanguage()),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: BlocListener(
                      cubit: BlocProvider.of<ImagePickerBloc>(context),
                      listener: (context, state) {
                        if (state is ImageSelectedState &&
                            state.image != null) {
                          Fluttertoast.showToast(
                              msg: "Profile image changed",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          imageHolder = true;
                          _image = state.image;
                        } else {
                          Fluttertoast.showToast(
                              msg: "Something went wrong..!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: imageSelection(context)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  " Login and Security",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                SizedBox(
                  height: 20,
                ),
                SecurityPage(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  " Saved Cards",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                // BlocListener(
                //   cubit: BlocProvider.of<DataListBloc>(context),
                //   listener: (context, state) {
                //     if (state is AddDataState) {
                //       list = state.cards;
                //       print(list.last.expiry);
                //     }
                //     if (state is NoDataState) {
                //       print(
                //           "-------------------------------------------------------------No data State");
                //     }
                //   },
                BlocBuilder<DataListBloc, DataListState>(
                    cubit: BlocProvider.of<DataListBloc>(context),
                    builder: (context, state) {
                      final dataBloc = BlocProvider.of<DataListBloc>(context);
                      // print(list.last.expiry + "");
                      if (state is NoDataState) {
                        print("object");
                        dataBloc.add(InitialDataEvent());
                      }

                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: dataBloc.getCardList().length,
                          itemBuilder: (context, index) => Stack(
                                children: [
                                  Positioned(
                                      right: 0,
                                      top: 0,
                                      child: IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: () {
                                            dataBloc.add(DeleteDataEvent(
                                                dataBloc.getCardList()[index]));
                                          })),
                                  new CardModel(
                                      dataBloc.getCardList()[index].name,
                                      dataBloc.getCardList()[index].card,
                                      dataBloc.getCardList()[index].number,
                                      dataBloc.getCardList()[index].expiry),
                                ],
                              ));
                    }),

                SizedBox(
                  height: 20,
                ),
                Text(
                  " Add A new Card",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                SizedBox(
                  height: 20,
                ),
                BlocProvider<DataListBloc>(
                  create: (BuildContext context) => DataListBloc(),
                  child: AddCardPage(),
                )

                // savedCards(context),
              ],
            ),
          ),
        ));
  }

  // Widget savedCards(context) {
  //   // return ;
  // }

  imageSelection(context) => BlocBuilder<ImagePickerBloc, ImagePickerState>(
      cubit: BlocProvider.of<ImagePickerBloc>(context),
      builder: (context, state) {
        // ignore: close_sinks
        final imagePickBloc = context.bloc<ImagePickerBloc>();
        return Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                //padding: const EdgeInsets.all(8.0),
                radius: 60,
                backgroundColor: Colors.orange,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage: imageHolder
                      ? FileImage(_image)
                      : AssetImage("assets/contact.jpg"),
                  radius: 60,
                ),
              ),
            ),
            Expanded(
                child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .6,
                  child: FlatButton(
                    onPressed: () {
                      imagePickBloc
                          .add(ImageSelectedEvent(source: ImageSource.gallery));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo_album_sharp,
                          size: 40,
                        ),
                        Text("Choose from gallery",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blueAccent,
                            ))
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .6,
                  child: FlatButton(
                    onPressed: () {
                      imagePickBloc
                          .add(ImageSelectedEvent(source: ImageSource.camera));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera,
                          size: 40,
                        ),
                        Text("Take a picture",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blueAccent,
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ))
          ],
        );
      });
}
