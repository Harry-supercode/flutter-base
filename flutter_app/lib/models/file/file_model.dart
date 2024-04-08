import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_app/components/gallery/gallery_page.dart';
import 'package:uuid/uuid.dart';

enum UploadStatus { init, uploading, success, failed, cancelled, tooLarge }

class FileModel {
  File? file;
  String? id = const Uuid().v4();
  bool isSelected;
  int? idMedia;
  double progress = 0.0;
  UploadStatus status;
  CancelToken cancelToken;
  String uploadType = GridGallery.event;
  String? fileName;
  String? url;
  bool isEditMode = false;

  FileModel(
      {this.file,
      this.id,
      this.progress = 0.0,
      this.idMedia,
      this.isSelected = false,
      this.isEditMode = false,
      required this.cancelToken,
      this.uploadType = GridGallery.event,
      this.fileName,
      this.url,
      this.status = UploadStatus.init});

// FileModel.fromJson(Map<String, dynamic> json) {
//   file = json['file'];
//   id = json['id'];
//   progress = json['progress'];
//   isSelected = json['isSelected'];
// }
//
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = {};
//   data['file'] = file;
//   data['id'] = id;
//   data['isSelected'] = isSelected;
//   data['progress'] = progress;
//   return data;
// }
}
