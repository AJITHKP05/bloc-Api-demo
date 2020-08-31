part of 'image_picker_bloc.dart';

@immutable
abstract class ImagePickerState {}

class NoImageSelectedState extends ImagePickerState {}

class ImageSelectedState extends ImagePickerState {
  final File image;
  ImageSelectedState({this.image});
}
