// Copyright 2019 The FlutterCandies author. All rights reserved.
// Use of this source code is governed by an Apache license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../extensions/l10n_extensions.dart';

/// Provide common usages of the picker.
/// 提供常见的选择器调用方式。
List<PickMethod> pickMethods(BuildContext context) {
  return <PickMethod>[
    PickMethod(
      icon: '📷',
      name: context.l10n.pickMethodPhotosName,
      description: context.l10n.pickMethodPhotosDescription,
      method: (BuildContext context) => CameraPicker.pickFromCamera(context),
    ),
    PickMethod(
      icon: '📹',
      name: context.l10n.pickMethodPhotosAndVideosName,
      description: context.l10n.pickMethodPhotosAndVideosDescription,
      method: (BuildContext context) => CameraPicker.pickFromCamera(
        context,
        pickerConfig: const CameraPickerConfig(enableRecording: true),
      ),
    ),
    PickMethod(
      icon: '🎥',
      name: context.l10n.pickMethodVideosName,
      description: context.l10n.pickMethodVideosDescription,
      method: (BuildContext context) => CameraPicker.pickFromCamera(
        context,
        pickerConfig: CameraPickerConfig(
          preferredFlashMode: FlashMode.auto,
          textDelegate: CustomPickerTextDelegate(),
          enableRecording: true,
          onlyEnableRecording: true,
          enableTapRecording: true,
          enableAudio: false,
          shouldAutoPreviewVideo: false,
          resolutionPreset: ResolutionPreset.medium,
          lockCaptureOrientation: DeviceOrientation.landscapeRight,
          maximumRecordingDuration: const Duration(minutes: 1),
          theme: CustomPickerTextDelegate.themeData(
            const Color(0xff00bc56),
          ),
          onXFileCaptured: (file, preview) {
            var video = file;
            debugPrint("@232 we got video at ${video?.path}");
            Navigator.of(context).pop();
            return true;
          },
          onError: (e, s) async {
            debugPrint("@227 $e :: $s");
            //PROD: comment this
            // if (e is CameraException) {
            //   video = await ImagePicker()
            //       .pickVideo(source: ImageSource.gallery);
            // }
          },
        ),
      ),
    ),
    PickMethod(
      icon: '📽',
      name: context.l10n.pickMethodVideosByTapName,
      description: context.l10n.pickMethodVideosByTapDescription,
      method: (BuildContext context) => CameraPicker.pickFromCamera(
        context,
        pickerConfig: const CameraPickerConfig(
          enableRecording: true,
          onlyEnableRecording: true,
          enableTapRecording: true,
        ),
      ),
    ),
    PickMethod(
      icon: '🈲',
      name: context.l10n.pickMethodSilenceRecordingName,
      description: context.l10n.pickMethodSilenceRecordingDescription,
      method: (BuildContext context) => CameraPicker.pickFromCamera(
        context,
        pickerConfig: const CameraPickerConfig(
          enableRecording: true,
          onlyEnableRecording: true,
          enableTapRecording: true,
          enableAudio: false,
        ),
      ),
    ),
    PickMethod(
      icon: '⏳',
      name: context.l10n.pickMethodNoDurationLimitName,
      description: context.l10n.pickMethodNoDurationLimitDescription,
      method: (BuildContext context) => CameraPicker.pickFromCamera(
        context,
        pickerConfig: const CameraPickerConfig(
          enableRecording: true,
          onlyEnableRecording: true,
          enableTapRecording: true,
          maximumRecordingDuration: null,
        ),
      ),
    ),
    PickMethod(
      icon: '🎨',
      name: context.l10n.pickMethodCustomizableThemeName,
      description: context.l10n.pickMethodCustomizableThemeDescription,
      method: (BuildContext context) => CameraPicker.pickFromCamera(
        context,
        pickerConfig: CameraPickerConfig(
          theme: CameraPicker.themeData(Colors.blue),
        ),
      ),
    ),
    PickMethod(
      icon: '↩️',
      name: context.l10n.pickMethodRotateInTurnsName,
      description: context.l10n.pickMethodRotateInTurnsDescription,
      method: (BuildContext context) => CameraPicker.pickFromCamera(
        context,
        pickerConfig: const CameraPickerConfig(cameraQuarterTurns: 1),
      ),
    ),
    PickMethod(
      icon: '🔍',
      name: context.l10n.pickMethodScalingPreviewName,
      description: context.l10n.pickMethodScalingPreviewDescription,
      method: (BuildContext context) => CameraPicker.pickFromCamera(
        context,
        pickerConfig: const CameraPickerConfig(enableScaledPreview: true),
      ),
    ),
    PickMethod(
      icon: '🌀',
      name: context.l10n.pickMethodLowerResolutionName,
      description: context.l10n.pickMethodLowerResolutionDescription,
      method: (BuildContext context) => CameraPicker.pickFromCamera(
        context,
        pickerConfig: const CameraPickerConfig(
          resolutionPreset: ResolutionPreset.low,
        ),
      ),
    ),
    PickMethod(
      icon: '🤳',
      name: context.l10n.pickMethodPreferFrontCameraName,
      description: context.l10n.pickMethodPreferFrontCameraDescription,
      method: (BuildContext context) => CameraPicker.pickFromCamera(
        context,
        pickerConfig: const CameraPickerConfig(
          preferredLensDirection: CameraLensDirection.front,
        ),
      ),
    ),
    PickMethod(
      icon: '📸',
      name: context.l10n.pickMethodPreferFlashlightOnName,
      description: context.l10n.pickMethodPreferFlashlightOnDescription,
      method: (BuildContext context) => CameraPicker.pickFromCamera(
        context,
        pickerConfig: const CameraPickerConfig(
          preferredFlashMode: FlashMode.always,
        ),
      ),
    ),
    PickMethod(
      icon: '🪄',
      name: context.l10n.pickMethodForegroundBuilderName,
      description: context.l10n.pickMethodForegroundBuilderDescription,
      method: (BuildContext context) => CameraPicker.pickFromCamera(
        context,
        pickerConfig: CameraPickerConfig(
          foregroundBuilder: (
            BuildContext context,
            CameraController? controller,
          ) {
            return Center(
              child: Text(
                controller == null
                    ? 'Waiting for initialize...'
                    : '${controller.description.lensDirection}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    ),
  ];
}

class CustomPickerTextDelegate extends EnglishCameraPickerTextDelegate {
  @override
  String get sActionStopRecordingHint => "Record";

  static ThemeData themeData(Color themeColor) {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.grey[900],
      primaryColorLight: Colors.grey[900],
      primaryColorDark: Colors.grey[900],
      canvasColor: Colors.grey[850],
      scaffoldBackgroundColor: Colors.grey[900],
      cardColor: Colors.grey[900],
      highlightColor: Colors.transparent,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: themeColor,
        selectionColor: themeColor.withAlpha(100),
        selectionHandleColor: themeColor,
      ),
      indicatorColor: themeColor,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
      ),
      buttonTheme: ButtonThemeData(buttonColor: themeColor),
      colorScheme: ColorScheme(
        primary: Colors.grey[900]!,
        primaryContainer: Colors.grey[900],
        secondary: themeColor,
        secondaryContainer: themeColor,
        surface: Colors.grey[900]!,
        brightness: Brightness.dark,
        error: const Color(0xffcf6679),
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onError: Colors.black,
      ),
    );
  }
}

/// Define a regular pick method.
final class PickMethod {
  const PickMethod({
    required this.icon,
    required this.name,
    required this.description,
    required this.method,
    this.onLongPress,
  });

  final String icon;
  final String name;
  final String description;

  /// The core function that defines how to use the picker.
  final Future<AssetEntity?> Function(BuildContext context) method;

  final GestureLongPressCallback? onLongPress;
}
