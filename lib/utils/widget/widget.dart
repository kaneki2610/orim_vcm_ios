import 'dart:core';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

enum ImageType { NETWORK, FILE, ASSET, MEMORY }

class ImageView extends StatefulWidget {
  final ImageFrameBuilder frameBuilder;
  final ImageLoadingBuilder loadingBuilder;
  final String semanticLabel;
  final bool excludeFromSemantics;
  final double width;
  final double height;
  final Color color;
  final BlendMode colorBlendMode;
  final BoxFit fit;
  final Alignment alignment;
  final ImageRepeat repeat;
  final Rect centerSlice;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final FilterQuality filterQuality;

  final ImageType type;
  final _DataImage data;

  ImageView.network(
    String src, {
    Key key,
    double scale = 1.0,
    this.frameBuilder,
    this.loadingBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
    Map<String, String> headers,
    int cacheWidth,
    int cacheHeight,
  })  : type = ImageType.NETWORK,
        data = _DataImage(
            source: src,
            scale: scale,
            headers: headers,
            cacheHeight: cacheHeight,
            cacheWidth: cacheWidth);

  ImageView.file(
    File file, {
    Key key,
    double scale = 1.0,
    this.frameBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
    int cacheWidth,
    int cacheHeight,
  })  : type = ImageType.FILE,
        loadingBuilder = null,
        data = _DataImage(
            scale: scale,
            file: file,
            cacheHeight: cacheHeight,
            cacheWidth: cacheWidth);

  ImageView.asset(
    String name, {
    Key key,
    AssetBundle bundle,
    this.frameBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    double scale,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    String package,
    this.filterQuality = FilterQuality.low,
    int cacheWidth,
    int cacheHeight,
  })  : type = ImageType.ASSET,
        loadingBuilder = null,
        data = _DataImage(
            nameAsset: name,
            scale: scale,
            bundle: bundle,
            package: package,
            cacheHeight: cacheHeight,
            cacheWidth: cacheWidth);

  ImageView.memory(
    Uint8List bytes, {
    Key key,
    double scale = 1.0,
    this.frameBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
    int cacheWidth,
    int cacheHeight,
  })  : type = ImageType.MEMORY,
        loadingBuilder = null,
        data = _DataImage(
            bytes: bytes,
            scale: scale,
            cacheHeight: cacheHeight,
            cacheWidth: cacheWidth);

  @override
  State<StatefulWidget> createState() {
    return _ImageState();
  }
}

class _ImageState extends State<ImageView> {
  ImageProvider image;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.data.isHEICFormatFile()) {
        _processFileSpecialFormat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case ImageType.NETWORK:
        return _renderImageNetwork(context);
      case ImageType.MEMORY:
        return _renderImageMemory(context);
      case ImageType.FILE:
        return _renderImageFile(context);
      case ImageType.ASSET:
        return _renderImageAsset(context);
      default:
        throw "unknown type";
    }
  }

  Widget _renderImageNetwork(BuildContext context) {
    final _DataImage data = widget.data;
    ImageLoadingBuilder loadingBuilder;
    if (widget.loadingBuilder == null) {
      loadingBuilder = (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return
        Container(
          height: widget.height,
          width: widget.width,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      };
    } else {
      loadingBuilder = widget.loadingBuilder;
    }
    return Image.network(
      data.source,
      key: widget.key,
      scale: data.scale,
      frameBuilder: widget.frameBuilder,
      loadingBuilder: loadingBuilder,
      semanticLabel: widget.semanticLabel,
      excludeFromSemantics: widget.excludeFromSemantics,
      width: widget.width,
      height: widget.height,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      fit: widget.fit,
      alignment: widget.alignment,
      repeat: widget.repeat,
      centerSlice: widget.centerSlice,
      matchTextDirection: widget.matchTextDirection,
      gaplessPlayback: widget.gaplessPlayback,
      filterQuality: widget.filterQuality,
      headers: data.headers,
      cacheHeight: data.cacheHeight,
      cacheWidth: data.cacheWidth,
    );
  }

  Widget _renderImageMemory(BuildContext context) {
    final _DataImage data = widget.data;
    return Image.memory(
      data.bytes,
      key: widget.key,
      scale: data.scale,
      frameBuilder: widget.frameBuilder,
      semanticLabel: widget.semanticLabel,
      excludeFromSemantics: widget.excludeFromSemantics,
      width: widget.width,
      height: widget.height,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      fit: widget.fit,
      alignment: widget.alignment,
      repeat: widget.repeat,
      centerSlice: widget.centerSlice,
      matchTextDirection: widget.matchTextDirection,
      gaplessPlayback: widget.gaplessPlayback,
      filterQuality: widget.filterQuality,
      cacheHeight: data.cacheHeight,
      cacheWidth: data.cacheWidth,
    );
  }

  Widget _renderImageAsset(BuildContext context) {
    final _DataImage data = widget.data;
    return Image.asset(
      data.nameAsset,
      key: widget.key,
      bundle: data.bundle,
      frameBuilder: widget.frameBuilder,
      semanticLabel: widget.semanticLabel,
      excludeFromSemantics: widget.excludeFromSemantics,
      scale: data.scale,
      width: widget.width,
      height: widget.height,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      fit: widget.fit,
      alignment: widget.alignment,
      repeat: widget.repeat,
      centerSlice: widget.centerSlice,
      matchTextDirection: widget.matchTextDirection,
      gaplessPlayback: widget.gaplessPlayback,
      package: data.package,
      filterQuality: widget.filterQuality,
      cacheHeight: data.cacheHeight,
      cacheWidth: data.cacheWidth,
    );
  }

  Widget _renderImageFile(BuildContext context) {
    final _DataImage data = widget.data;
    if (!data.isHEICFormatFile()) {
      return _renderImageFileNormal();
    } else {
      return _renderImageSpecial();
    }
  }

  Widget _renderImageFileNormal() {
    final _DataImage data = widget.data;
    return Image.file(
      data.file,
      key: widget.key,
      scale: data.scale,
      frameBuilder: widget.frameBuilder,
      semanticLabel: widget.semanticLabel,
      excludeFromSemantics: widget.excludeFromSemantics,
      width: widget.width,
      height: widget.height,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      fit: widget.fit,
      alignment: widget.alignment,
      repeat: widget.repeat,
      centerSlice: widget.centerSlice,
      matchTextDirection: widget.matchTextDirection,
      gaplessPlayback: widget.gaplessPlayback,
      filterQuality: widget.filterQuality,
      cacheHeight: data.cacheHeight,
      cacheWidth: data.cacheWidth,
    );
  }

  Widget _renderImageSpecial() {
    if (image != null) {
      return Image(
        image: image,
        frameBuilder: widget.frameBuilder,
        loadingBuilder: null,
        semanticLabel: widget.semanticLabel,
        excludeFromSemantics: widget.excludeFromSemantics,
        width: widget.width,
        height: widget.height,
        color: widget.color,
        colorBlendMode: widget.colorBlendMode,
        fit: widget.fit,
        alignment: widget.alignment,
        repeat: widget.repeat,
        centerSlice: widget.centerSlice,
        matchTextDirection: widget.matchTextDirection,
        gaplessPlayback: widget.gaplessPlayback,
        filterQuality: widget.filterQuality,
      );
    } else {
      return Container(
        width: widget.width,
        height: widget.height,
      );
    }
  }

  void _processFileSpecialFormat() async {
    ImageProvider imageProvider =
        await _compressFile(widget.data.file, widget.data.scale);
    setState(() {
      image = imageProvider;
    });
  }
}

class _DataImage {
  final double scale;
  final Map<String, String> headers;
  final int cacheWidth;
  final int cacheHeight;

  // network
  final String source;

  // file
  final File file;

  // asset
  final String nameAsset;
  final AssetBundle bundle;
  final String package;

  // memory
  final Uint8List bytes;

  _DataImage(
      {this.scale,
      this.headers,
      this.cacheWidth,
      this.cacheHeight,
      this.source,
      this.file,
      this.nameAsset,
      this.bundle,
      this.package,
      this.bytes});

  bool isHEICFormatFile() {
    if (file != null) {
      if (file.path.toLowerCase().contains('.heic')) {
        return true;
      }
    }
    return false;
  }
}

Future<ImageProvider> _compressFile(File file, double scale) async {
  double quality = scale != null ? scale * 100 : 100;
  List<int> result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    quality: quality.toInt(),
  );
  return MemoryImage(Uint8List.fromList(result));
}
