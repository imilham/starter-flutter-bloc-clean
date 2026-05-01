// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:octo_image/octo_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:starter/utils/extensions/theme_extension.dart';

/// A service provider for image utilities.
///
/// Provides methods for picking, cropping, compressing images and building
/// image viewer widgets with tap-to-zoom support.
class AppImageUtils {
  AppImageUtils._() {
    _init();
  }
  static AppImageUtils? _instance;

  static AppImageUtils get instance {
    _instance ??= AppImageUtils._();
    return _instance!;
  }

  /// Initializes the image picker platform and sets the Android photo picker option if the platform is Android.
  void _init() {
    final imagePickerPlatform = ImagePickerPlatform.instance;
    if (imagePickerPlatform is ImagePickerAndroid) {
      imagePickerPlatform.useAndroidPhotoPicker = true;
    }
  }

  /// Picks an image from the gallery, then crops and compresses it.
  Future<CroppedFile?> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return null;
    return _cropAndCompressImage(file: File(pickedImage.path));
  }

  /// Takes an image using the camera, then crops and compresses it.
  Future<CroppedFile?> takeImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) return null;

    final file = File(pickedImage.path);
    final fileSize = await file.length();
    log('Before cropping: ${_formatBytes(fileSize)}');

    return _cropAndCompressImage(file: file);
  }

  Future<CroppedFile?> _cropAndCompressImage({required File file}) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.green,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: 'Crop Image', minimumAspectRatio: 1),
      ],
    );

    if (croppedFile == null) return null;

    final croppedFileSize = await File(croppedFile.path).length();
    log('After cropping: ${_formatBytes(croppedFileSize)}');

    final compressedFile = await _compressImage(File(croppedFile.path));

    if (compressedFile != null) {
      final compressedSize = await compressedFile.length();
      log('After compression: ${_formatBytes(compressedSize)}');
      return CroppedFile(compressedFile.path);
    }

    return null;
  }

  Future<XFile?> _compressImage(File file) async {
    final directory = await getTemporaryDirectory();
    final targetPath = '${directory.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';
    return FlutterImageCompress.compressAndGetFile(file.path, targetPath, quality: 80);
  }

  String _formatBytes(int bytes) {
    final kb = bytes / 1024;
    final mb = kb / 1024;
    return '$bytes bytes | ${kb.toStringAsFixed(2)} KB | ${mb.toStringAsFixed(2)} MB';
  }

  /// Builds an image widget based on the provided parameters.
  ///
  /// Exactly one of [image], [imageUrl], [imageFile], or [assetsPath] must be provided.
  Widget buildImageWidget({
    Uint8List? image,
    Uri? imageUrl,
    File? imageFile,
    String? assetsPath,
    BoxFit fit = BoxFit.cover,
    BorderRadius borderRadius = BorderRadius.zero,
  }) {
    assert(
      image != null || imageUrl != null || imageFile != null || assetsPath != null,
      'At least one image source must be provided.',
    );
    assert(
      [image != null, imageUrl != null, imageFile != null, assetsPath != null].where((b) => b).length == 1,
      'Only one image source can be provided.',
    );

    if (image != null) {
      return _MemoryImageViewer(image: image, fit: fit, borderRadius: borderRadius);
    } else if (imageFile != null) {
      return _FileImageViewer(imageFile: imageFile, fit: fit, borderRadius: borderRadius);
    } else if (imageUrl != null) {
      return _NetworkImageViewer(imageUri: imageUrl, fit: fit, borderRadius: borderRadius);
    } else if (assetsPath != null) {
      return _AssetsImageViewer(imagePath: assetsPath, fit: fit, borderRadius: borderRadius);
    }
    return const Center(child: Icon(Icons.warning_amber_rounded, size: 32, color: Colors.red));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helper: shows a full-screen PhotoView dialog with a blur backdrop.
// ─────────────────────────────────────────────────────────────────────────────

Future<void> _showImageViewer(BuildContext context, ImageProvider provider) async {
  await showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Close',
    barrierColor: Colors.white.withValues(alpha: 0.6),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: AspectRatio(
          aspectRatio: 0.8,
          child: PhotoView(
            imageProvider: provider,
            backgroundDecoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20 * animation.value,
          sigmaY: 20 * animation.value,
        ),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}

Widget _buildTappableImage({
  required BuildContext context,
  required ImageProvider provider,
  required Widget child,
  required BorderRadius borderRadius,
}) {
  return GestureDetector(
    onTap: () => _showImageViewer(context, provider),
    child: borderRadius != BorderRadius.zero
        ? ClipRRect(borderRadius: borderRadius, child: child)
        : child,
  );
}

Widget _buildErrorPlaceholder(BuildContext context, BorderRadius borderRadius) {
  return Container(
    decoration: BoxDecoration(
      color: context.colorScheme.secondary.withValues(alpha: 0.1),
      borderRadius: borderRadius,
    ),
    child: Center(
      child: Icon(Icons.warning_amber_rounded, size: 32, color: context.colorScheme.error),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Image Viewer Widgets
// ─────────────────────────────────────────────────────────────────────────────

class _NetworkImageViewer extends StatelessWidget {
  const _NetworkImageViewer({
    required this.imageUri,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
  });

  final Uri imageUri;
  final BoxFit fit;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    if (imageUri.toString().isEmpty) {
      return _buildErrorPlaceholder(context, borderRadius);
    }
    final provider = CachedNetworkImageProvider(imageUri.toString());
    return OctoImage(
      image: provider,
      fit: fit,
      imageBuilder: (context, child) =>
          _buildTappableImage(context: context, provider: provider, child: child, borderRadius: borderRadius),
      errorBuilder: (context, error, stackTrace) => _buildErrorPlaceholder(context, borderRadius),
    );
  }
}

class _MemoryImageViewer extends StatelessWidget {
  const _MemoryImageViewer({
    required this.image,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
  });

  final Uint8List image;
  final BoxFit fit;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final provider = MemoryImage(image);
    return OctoImage(
      image: provider,
      fit: fit,
      imageBuilder: (context, child) =>
          _buildTappableImage(context: context, provider: provider, child: child, borderRadius: borderRadius),
      errorBuilder: (context, error, stackTrace) => _buildErrorPlaceholder(context, borderRadius),
    );
  }
}

class _FileImageViewer extends StatelessWidget {
  const _FileImageViewer({
    required this.imageFile,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
  });

  final File imageFile;
  final BoxFit fit;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final provider = FileImage(imageFile);
    return OctoImage(
      image: provider,
      fit: fit,
      imageBuilder: (context, child) =>
          _buildTappableImage(context: context, provider: provider, child: child, borderRadius: borderRadius),
      errorBuilder: (context, error, stackTrace) => _buildErrorPlaceholder(context, borderRadius),
    );
  }
}

class _AssetsImageViewer extends StatelessWidget {
  const _AssetsImageViewer({
    required this.imagePath,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
  });

  final String imagePath;
  final BoxFit fit;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      image: AssetImage(imagePath),
      fit: fit,
      imageBuilder: (context, child) {
        if (borderRadius != BorderRadius.zero) {
          return ClipRRect(borderRadius: borderRadius, child: child);
        }
        return child;
      },
      errorBuilder: (context, error, stackTrace) => _buildErrorPlaceholder(context, borderRadius),
    );
  }
}
