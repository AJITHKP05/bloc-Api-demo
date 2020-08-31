import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(NoImageSelectedState());

  File _image;

  final picker = ImagePicker();

  @override
  Stream<ImagePickerState> mapEventToState(
    ImagePickerEvent event,
  ) async* {
    if (event is NoImageSelectedEvent) yield NoImageSelectedState();
    if (event is ImageSelectedEvent) {
      await setImage(event.source);
      yield ImageSelectedState(image: _image);
    }
  }

  Future setImage(ImageSource source) async {
    await picker.getImage(source: source).then((image) async {
      if (image != null) {
        await ImageCropper.cropImage(sourcePath: image.path).then((crop) {
          this._image = crop;
        });
      }
    });
  }
}
