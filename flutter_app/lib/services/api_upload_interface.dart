import 'package:flutter_app/models/file/file_model.dart';

abstract class ApiUploadInterface {
  /// Upload in queue slot 1
  /// @param [FileModel]
  Future uploadFile(FileModel file);

  /// Upload in queue slot 2
  /// @param [FileModel]
  Future uploadFile2(FileModel file);

  /// Upload in queue slot 3
  /// @param [FileModel]
  Future uploadFile3(FileModel file);
}
