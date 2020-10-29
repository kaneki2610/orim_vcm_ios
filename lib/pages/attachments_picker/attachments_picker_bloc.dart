import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/utils/gallery_storage/attachement.dart';
import 'package:orim/utils/gallery_storage/gallery_storage.dart';
import 'package:provider/provider.dart';

const timeReloadLibrary = 0; // second

class AttachmentsPickerBloc extends BaseBloc {
  AttachmentsPickerBloc(
      {BuildContext context, List<Attachment> listImageSelected})
      : super(context: context) {
    for (final selected in listImageSelected) {
      if (selected.isImage()) {
        maxNumImageSelected--;
      } else if (selected.isVideo()) {
        maxNumVideoSelected--;
      }
    }
    _countNumVideoSubject.value = numCountVideoSelected;
    _countNumImageSubject.value = numCountImageSelected;
  }

//  final List<Attachment> _listImageSelected;

  int maxNumVideoSelected = 1;
  int maxNumImageSelected = 5;

  List<Attachment> data = [];
  int numCountImageSelected = 0;
  int numCountVideoSelected = 0;
  BehaviorSubject<List<Attachment>> _subject = BehaviorSubject();

  Stream<List<Attachment>> get dataObserver => _subject.stream;
  GalleryStorage _galleryStorage;
  Timer _timer;

  bool isLoadLibrary = false;

  bool get canOpenCamera => numCountImageSelected < maxNumImageSelected;

  bool get canRecordVideo => numCountVideoSelected < maxNumVideoSelected;

  BehaviorSubject<int> _countNumVideoSubject = BehaviorSubject();

  Stream<int> get countNumVideoObserver => _countNumVideoSubject.stream;
  BehaviorSubject<int> _countNumImageSubject = BehaviorSubject();

  Stream<int> get countNumImageObserver => _countNumImageSubject.stream;

  Future<bool> requestPermission() async {
    return await _galleryStorage.requestPermission();
  }

  Future<void> _loadAllPhotoAndVideo() async {
    try {
      List<Attachment> attachments =
          await _galleryStorage.getAllPhotoAndImage();
      if (data.isEmpty) {
//        if (_listImageSelected.length > 0) {
//          List<int> skip = [];
//          for (final selected in _listImageSelected) {
//            for (int index = 0; index < attachments.length; index++) {
//              if (skip.indexOf(index) == -1) {
//                final attachment = attachments[index];
//                if (selected == attachment) {
//                  attachment.selected = true;
//                  skip.add(index);
//                  break;
//                }
//              }
//            }
//          }
//        }
        data.addAll(attachments);
        _subject.value = data;
      } else {
        if (data[0] != attachments[0]) {
          attachments[0].selected = true;
          data.insert(0, attachments[0]);
          _subject.value = data;
        }
      }
    } catch (err) {
      throw err;
    }
  }

  Future<void> openVideoView() async {
    File fileVideo;
    try {
      fileVideo = await ImagePicker.pickVideo(source: ImageSource.camera);
    } catch (err) {
      print(err);
    }
    if (fileVideo != null) {
//      AlbumSaver.saveToAlbum(filePath: fileVideo.path, albumName: 'Camera')
//          .then((_) {
//        _afterSave(AssetType.video);
//      }).catchError((err) {
//        print('err $err');
//      });
//      GallerySaver.saveVideo(fileVideo.path, albumName: 'DCIM/Camera').then((String path) {
//        if (path.isNotEmpty) {
//          _afterSave(path, AssetType.video);
//        }
//      });
//      _galleryStorage.saveVideo(fileVideo).then((Attachment attachment) {
//        _afterSave(attachment, AssetType.video);
//      }).catchError((err) {
//        print(err);
//      });
    }
  }

  Future<void> openCameraView() async {
    File fileImage;
    try {
      fileImage = await ImagePicker.pickImage(source: ImageSource.camera);
    } catch (err) {
      print(err);
    }
    if (fileImage != null) {
//      AlbumSaver.saveToAlbum(filePath: fileImage.path, albumName: 'Camera')
//          .then((_) {
//        _afterSave(AssetType.image);
//      }).catchError((err) {
//        print('err $err');
//      });
//      GallerySaver.saveImage(fileImage.path, albumName: 'DCIM/Camera').then((String path) {
//        if (path.isNotEmpty) {
//          _afterSave(path, AssetType.image);
//        }
//      });
//      _galleryStorage
//          .saveImage(await fileImage.readAsBytes())
//          .then((Attachment attachment) {
//        _afterSave(attachment, AssetType.image);
//      }).catchError((err) {
//        print(err);
//      });
    }
  }

  bool selectItem(Attachment attachment) {
    final index = data.indexOf(attachment);
    if (index > -1) {
      if (_checkValidSelect(index)) {
        data[index].selected = !data[index].selected;
        _updateNumCount(index);
        _subject.value = data;
        return true;
      }
    }
    return false;
  }

  void _afterSave(Attachment attachment, AssetType type) {
//  void _afterSave(String filePath, AssetType type) async {
//    Attachment attachment;
//    try {
//      attachment = await _galleryStorage.getNewItem(type);
//    } catch (err) {
//      print(err);
//    }
    if (attachment != null) {
      attachment.selected = true;
      data.insert(0, attachment);
      _subject.value = data;
      switch (type) {
        case AssetType.image:
          numCountImageSelected++;
          break;
        case AssetType.video:
          numCountVideoSelected++;
          break;
      }
    }
  }

  bool _checkValidSelect(int index) {
    if (!data[index].selected) {
      // file not selected yet
      if (data[index].isImage()) {
        if (numCountImageSelected < maxNumImageSelected) {
          return true;
        }
      } else if (data[index].isVideo()) {
        if (numCountVideoSelected < maxNumVideoSelected) {
          return true;
        }
      }
    } else {
      return true;
    }
    return false;
  }

  void _updateNumCount(int index) {
    if (data[index].isVideo()) {
      if (data[index].selected) {
        numCountVideoSelected++;
      } else {
        numCountVideoSelected--;
      }
      _countNumVideoSubject.value = numCountVideoSelected;
    } else if (data[index].isImage()) {
      if (data[index].selected) {
        numCountImageSelected++;
      } else {
        numCountImageSelected--;
      }
      _countNumImageSubject.value = numCountImageSelected;
    }
  }

  List<Attachment> get itemSelected =>
      data.where((item) => item.selected).toList();

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    _galleryStorage = Provider.of<GalleryStorage>(context);
  }

  @override
  void dispose() {
    _countNumVideoSubject.close();
    _countNumImageSubject.close();
    _subject.close();
  }

  bool back() {
    return NavigatorService.back(context);
  }

  void openSetting() {
    _galleryStorage.openSettings();
  }

  Future<void> loadLibraryIfNeed() async {
    if (isLoadLibrary == false) {
      await _loadAllPhotoAndVideo();
      isLoadLibrary = true;
    }
  }
}
