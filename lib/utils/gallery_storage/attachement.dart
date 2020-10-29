import 'dart:io';
import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

class Attachment {
  File file;
  AssetType _type;
  Uint8List thumbnailData;
  String url;
  bool selected;

  Attachment(
      {this.file,
      AssetType type,
      this.thumbnailData,
      this.url,
      this.selected = false}) {
    assert(this.file != null || this.thumbnailData != null || this.url != null);
    _type = type;
  }

  bool isVideo() => _type == AssetType.video;

  bool isImage() => _type == AssetType.image;

  @override
  bool operator ==(covariant Attachment other) {
    return ((file != null &&
                other.file != null &&
                file.toString() == other.file.toString()) ||
//            (thumbnailData != null &&
//                thumbnailData.toString() == other.thumbnailData.toString()) ||
            (url != null && url == other.url)) &&
        _type == other._type;
  }
}
