import 'dart:io';
import 'dart:typed_data';

import 'package:ext_storage/ext_storage.dart';
import 'package:photo_manager/photo_manager.dart' as PM;

import 'attachement.dart';

class GalleryStorage {
  Future<bool> requestPermission() async {
    print('requestPermission');
    return await PM.PhotoManager.requestPermission();
  }

  Future<List<Attachment>> getAllPhotoAndImage() async {
    List<PM.AssetPathEntity> list;
    try {
      list = await PM.PhotoManager.getAssetPathList();
    } catch (err) {
      throw err;
    }
    if (list != null) {
      for (var sources in list) {
        if (sources.isAll) {
          List<PM.AssetEntity> list;
          try {
            list = await sources.assetList;
          } catch (err) {
            throw err;
          }
          if (list != null) {
            List<Attachment> attachments = [];
            for (final attachment in list) {
              if (attachment.type == PM.AssetType.image ||
                  attachment.type == PM.AssetType.video) {
                final File file = await attachment.file;
                Uint8List thumbnail = await attachment.thumbData;
                attachments.add(Attachment(
                  file: file,
                  type: attachment.type,
                  thumbnailData: thumbnail,
                ));
              }
            }
            return attachments;
          } else {
            return [];
          }
        } else {
          continue;
        }
      }
    } else {
      return [];
    }
  }

  Future<Attachment> getNewItem(AssetType type) async {
    List<PM.AssetPathEntity> list;
    try {
      list = await PM.PhotoManager.getAssetPathList();
    } catch (err) {
      throw err;
    }
    if (list != null) {
      PM.AssetType requestType;
      switch (type) {
        case AssetType.image:
          requestType = PM.AssetType.image;
          break;
        case AssetType.video:
          requestType = PM.AssetType.video;
          break;
        default:
          throw 'wrong type';
      }
      for (final sources in list) {
        print(sources.toString());
        if (sources.isAll) {
          List<PM.AssetEntity> list;
          try {
            list = await sources.assetList;
          } catch (err) {
            return null;
          }
          if (list != null) {
            if (list[0].type == requestType) {
              return Attachment(
                file: await list[0].file,
                type: list[0].type,
                thumbnailData: await list[0].thumbData,
              );
            }
          }
        }
      }
    }
    return null;
  }

  Future<bool> saveImage(File fileImage) async {
    if (Platform.isAndroid) {
      final String pathPictues =
          await ExtStorage.getExternalStoragePublicDirectory(
              ExtStorage.DIRECTORY_PICTURES);
      final List<String> filePathSplit = fileImage.path.split('/');
      try {
//        final File file = await fileImage
//            .copy('$pathPictues/${filePathSplit[filePathSplit.length - 1]}');
        PM.AssetEntity entity = await PM.PhotoManager.editor.saveImage(await fileImage.readAsBytes());
        if (entity != null) {
          print(entity.type);
          return true;
        }
      } catch (err) {
        print(err);
      }
      return false;
    } else {
      PM.AssetEntity entity = await PM.PhotoManager.editor.saveImage(await fileImage.readAsBytes());
      if (entity != null) {
        print(entity.type);
        return true;
      }
      return false;
    }
  }

  Future<bool> saveVideo(File fileVideo) async {
    if (Platform.isAndroid) {
      final String pathPictues =
          await ExtStorage.getExternalStoragePublicDirectory(
              ExtStorage.DIRECTORY_MOVIES);
      final List<String> filePathSplit = fileVideo.path.split('/');
      try {
//        final File file = await fileVideo
//            .copy('$pathPictues/${filePathSplit[filePathSplit.length - 1]}');
        PM.AssetEntity entity = await PM.PhotoManager.editor.saveVideo(fileVideo);
        if (entity != null) {
          print(entity.type);
          return true;
        }
      } catch (err) {
        print(err);
      }
      return false;
    } else {
      PM.AssetEntity entity = await PM.PhotoManager.editor.saveVideo(fileVideo);
      if (entity != null) {
        print(entity.type);
        return true;
      }
      return false;
    }
  }

  void openSettings() {
    PM.PhotoManager.openSetting();
  }
}

enum AssetType {
  image,
  video,
  camera,
  video_memory
}
