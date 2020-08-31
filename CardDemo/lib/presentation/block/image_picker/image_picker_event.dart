part of 'image_picker_bloc.dart';

@immutable
abstract class ImagePickerEvent {}

class NoImageSelectedEvent extends ImagePickerEvent {}

class ImageSelectedEvent extends ImagePickerEvent {
  final source;

  ImageSelectedEvent({this.source});
}
