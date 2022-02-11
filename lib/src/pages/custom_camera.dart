// import 'dart:async';
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:prestaprofe/src/providers/providers.dart';
// import 'package:provider/provider.dart';

// class CustomCamera extends StatefulWidget {
//   CustomCamera({Key? key}) : super(key: key);

//   @override
//   State<CustomCamera> createState() => _CustomCameraState();
// }

// /// Returns a suitable camera icon for direction.
// IconData getCameraLensIcon(CameraLensDirection direction) {
//   switch (direction) {
//     case CameraLensDirection.back:
//       return Icons.camera_rear;
//     case CameraLensDirection.front:
//       return Icons.camera_front;
//     case CameraLensDirection.external:
//       return Icons.camera;
//     default:
//       throw ArgumentError('Dirección de lente desconocida');
//   }
// }

// void logError(String code, String? message) {
//   if (message != null) {
//     print('Error: $code\nError Message: $message');
//   } else {
//     print('Error: $code');
//   }
// }

// class _CustomCameraState extends State<CustomCamera> with TickerProviderStateMixin {

//   CameraController? controller;
//   XFile? imageFile;
//   double _minAvailableExposureOffset = 0.0;
//   double _maxAvailableExposureOffset = 0.0;
//   double _currentExposureOffset = 0.0;
//   late AnimationController _flashModeControlRowAnimationController;
//   late Animation<double> _flashModeControlRowAnimation;
//   late AnimationController _exposureModeControlRowAnimationController;
//   late Animation<double> _exposureModeControlRowAnimation;
//   late AnimationController _focusModeControlRowAnimationController;
//   late Animation<double> _focusModeControlRowAnimation;
//   double _minAvailableZoom = 1.0;
//   double _maxAvailableZoom = 1.0;
//   double _currentScale = 1.0;
//   double _baseScale = 1.0;

//   // Counting pointers (number of user fingers on screen)
//   int _pointers = 0;

//     @override
//   void initState() {
//     super.initState();

//     _flashModeControlRowAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _flashModeControlRowAnimation = CurvedAnimation(
//       parent: _flashModeControlRowAnimationController,
//       curve: Curves.easeInCubic,
//     );
//     _exposureModeControlRowAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _exposureModeControlRowAnimation = CurvedAnimation(
//       parent: _exposureModeControlRowAnimationController,
//       curve: Curves.easeInCubic,
//     );
//     _focusModeControlRowAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _focusModeControlRowAnimation = CurvedAnimation(
//       parent: _focusModeControlRowAnimationController,
//       curve: Curves.easeInCubic,
//     );
//   }

//   @override
//   void dispose() {
//     _flashModeControlRowAnimationController.dispose();
//     _exposureModeControlRowAnimationController.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     final CameraController? cameraController = controller;

//     // App state changed before we got the chance to initialize.
//     if (cameraController == null || !cameraController.value.isInitialized) {
//       return;
//     }

//     if (state == AppLifecycleState.inactive) {
//       cameraController.dispose();
//     } else if (state == AppLifecycleState.resumed) {
//       onNewCameraSelected(cameraController.description);
//     }
//   }

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white.withOpacity(0.95),
//       key: _scaffoldKey,
//       body: FutureBuilder(
//         future: futureCameras(context),
//         builder: (context, snapshot) {
//         if(!snapshot.hasData){
//           return Container();
//         }
//         return Column(
//           children: [
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 child: Center(
//                   child: _cameraPreviewWidget(),
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   border: Border.all(
//                     color:
//                         controller != null && controller!.value.isRecordingVideo
//                             ? Colors.redAccent
//                             : Colors.grey,
//                     width: 1.0,
//                   ),
//                 ),
//               ),
//             ),
//             _captureControlRowWidget(),
//             Row(
//               children: [
//                  _modeControlRowWidget(),
//                  _cameraTogglesRowWidget(context),
//               ],
//             ),
//           ],
//         );
//         }
//       ),
//     );
//   }

//   /// Display the preview from the camera (or a message if the preview is not available).
//   Widget _cameraPreviewWidget() {
//     final CameraController? cameraController = controller;

//     if (cameraController == null || !cameraController.value.isInitialized) {
//       return const Text(
//         'Selecciona una cámara',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 24.0,
//           fontWeight: FontWeight.w900,
//         ),
//       );
//     } else {
//       return Listener(
//         onPointerDown: (_) => _pointers++,
//         onPointerUp: (_) => _pointers--,
//         child: CameraPreview(
//           controller!,
//           child: LayoutBuilder(
//               builder: (BuildContext context, BoxConstraints constraints) {
//             return GestureDetector(
//               behavior: HitTestBehavior.opaque,
//               onScaleStart: _handleScaleStart,
//               onScaleUpdate: _handleScaleUpdate,
//               onTapDown: (details) => onViewFinderTap(details, constraints),
//             );
//           }),
//         ),
//       );
//     }
//   }

//   void _handleScaleStart(ScaleStartDetails details) {
//     _baseScale = _currentScale;
//   }

//   Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
//     // When there are not exactly two fingers on screen don't scale
//     if (controller == null || _pointers != 2) {
//       return;
//     }

//     _currentScale = (_baseScale * details.scale)
//         .clamp(_minAvailableZoom, _maxAvailableZoom);

//     await controller!.setZoomLevel(_currentScale);
//   }

//   /// Display a bar with buttons to change the flash and exposure modes
//   Widget _modeControlRowWidget() {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconButton(
//             iconSize: 20,
//             icon: Icon(Icons.flash_on),
//             color: Color.fromRGBO(51, 114, 134, 1),
//             onPressed: controller != null ? onFlashModeButtonPressed : null,
//           ),
//           _flashModeControlRowWidget(),
//         ],
//       ),
//     );
//   }

//   Widget _flashModeControlRowWidget() {
//     return SizeTransition(
//       sizeFactor: _flashModeControlRowAnimation,
//       child: ClipRect(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             IconButton(
//               iconSize: 18,
//               icon: Icon(Icons.flash_off),
//               color: controller?.value.flashMode == FlashMode.off
//                   ? Colors.orange
//                   : Colors.blue,
//               onPressed: controller != null
//                   ? () => onSetFlashModeButtonPressed(FlashMode.off)
//                   : null,
//             ),
//             IconButton(
//               iconSize: 18,
//               icon: Icon(Icons.flash_auto),
//               color: controller?.value.flashMode == FlashMode.auto
//                   ? Colors.orange
//                   : Colors.blue,
//               onPressed: controller != null
//                   ? () => onSetFlashModeButtonPressed(FlashMode.auto)
//                   : null,
//             ),
//             IconButton(
//               iconSize: 18,
//               icon: Icon(Icons.flash_on),
//               color: controller?.value.flashMode == FlashMode.always
//                   ? Colors.orange
//                   : Colors.blue,
//               onPressed: controller != null
//                   ? () => onSetFlashModeButtonPressed(FlashMode.always)
//                   : null,
//             ),
//             IconButton(
//               iconSize: 18,
//               icon: Icon(Icons.highlight),
//               color: controller?.value.flashMode == FlashMode.torch
//                   ? Colors.orange
//                   : Colors.blue,
//               onPressed: controller != null
//                   ? () => onSetFlashModeButtonPressed(FlashMode.torch)
//                   : null,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Display the control bar with buttons to take pictures and record videos.
//   Widget _captureControlRowWidget() {
//     final CameraController? cameraController = controller;

//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconButton(
//             icon: Icon(Icons.camera_alt),
//             iconSize: 50,
//             color: Color.fromRGBO(51, 114, 134, 1),
//             onPressed: cameraController != null &&
//                     cameraController.value.isInitialized &&
//                     !cameraController.value.isRecordingVideo
//                 ? () async{
//                   await onTakePictureButtonPressed();
//                   Navigator.pop(context, imageFile);
//                 }
//                 : null,
//           ),
//         ],
//       ),
//     );
//   }

//   /// Display a row of toggle to select the camera (or a message if no camera is available).
//   Widget _cameraTogglesRowWidget(BuildContext context) {

//     final List<Widget> toggles = <Widget>[];

//     final customCameraProvider = Provider.of<CustomCameraProvider>(context, listen: false);

//     final onChanged = (CameraDescription? description) {
//       if (description == null) {
//         return;
//       }

//       onNewCameraSelected(description);
//     };

//     if (customCameraProvider.cameras.isEmpty) {
//       return const Text('No se encontró una cámara');
//     } else {
//       for (CameraDescription cameraDescription in customCameraProvider.cameras) {
//         toggles.add(
//           SizedBox(
//             width: 90.0,
//             child: RadioListTile<CameraDescription>(
//               activeColor: Color.fromRGBO(51, 114, 134, 1),
//               title: Icon(getCameraLensIcon(cameraDescription.lensDirection), color: Color.fromRGBO(51, 114, 134, 1)),
//               groupValue: controller?.description,
//               value: cameraDescription,
//               onChanged:
//                   controller != null && controller!.value.isRecordingVideo
//                       ? null
//                       : onChanged,
//             ),
//           ),
//         );
//       }
//     }

//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.only(right: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: toggles,
//         ),
//       ),
//     );
//   }

//   String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

//   void showInSnackBar(String message) {
//     // ignore: deprecated_member_use
//     _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
//   }

//   void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
//     if (controller == null) {
//       return;
//     }

//     final CameraController cameraController = controller!;

//     final offset = Offset(
//       details.localPosition.dx / constraints.maxWidth,
//       details.localPosition.dy / constraints.maxHeight,
//     );
//     cameraController.setExposurePoint(offset);
//     cameraController.setFocusPoint(offset);
//   }

//   void onNewCameraSelected(CameraDescription cameraDescription) async {
//     if (controller != null) {
//       await controller!.dispose();
//     }

//     final CameraController cameraController = CameraController(
//       cameraDescription,
//       kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
//       imageFormatGroup: ImageFormatGroup.jpeg,
//     );

//     controller = cameraController;

//     // If the controller is updated then update the UI.
//     cameraController.addListener(() {
//       if (mounted) setState(() {});
//       if (cameraController.value.hasError) {
//         showInSnackBar(
//             'Error de cámara ${cameraController.value.errorDescription}');
//       }
//     });

//     try {
//       await cameraController.initialize();
//       await Future.wait([
//         // The exposure mode is currently not supported on the web.
//         ...(!kIsWeb
//             ? [
//                 cameraController
//                     .getMinExposureOffset()
//                     .then((value) => _minAvailableExposureOffset = value),
//                 cameraController
//                     .getMaxExposureOffset()
//                     .then((value) => _maxAvailableExposureOffset = value)
//               ]
//             : []),
//         cameraController
//             .getMaxZoomLevel()
//             .then((value) => _maxAvailableZoom = value),
//         cameraController
//             .getMinZoomLevel()
//             .then((value) => _minAvailableZoom = value),
//       ]);
//     } on CameraException catch (e) {
//       _showCameraException(e);
//     }

//     if (mounted) {
//       setState(() {});
//     }
//   }

//   Future onTakePictureButtonPressed() async{
//     try {
//       final XFile? file = await takePicture();
//       if (mounted) {
//         setState(() {
//           imageFile = file;
//         });
//         if (file != null){
//           showInSnackBar('Picture saved to ${file.path}');
//         }
//       }
      
//     } catch (e) {
//     }

//   }

//   void onFlashModeButtonPressed() {
//     if (_flashModeControlRowAnimationController.value == 1) {
//       _flashModeControlRowAnimationController.reverse();
//     } else {
//       _flashModeControlRowAnimationController.forward();
//       _exposureModeControlRowAnimationController.reverse();
//       _focusModeControlRowAnimationController.reverse();
//     }
//   }

//   void onExposureModeButtonPressed() {
//     if (_exposureModeControlRowAnimationController.value == 1) {
//       _exposureModeControlRowAnimationController.reverse();
//     } else {
//       _exposureModeControlRowAnimationController.forward();
//       _flashModeControlRowAnimationController.reverse();
//       _focusModeControlRowAnimationController.reverse();
//     }
//   }

//   void onFocusModeButtonPressed() {
//     if (_focusModeControlRowAnimationController.value == 1) {
//       _focusModeControlRowAnimationController.reverse();
//     } else {
//       _focusModeControlRowAnimationController.forward();
//       _flashModeControlRowAnimationController.reverse();
//       _exposureModeControlRowAnimationController.reverse();
//     }
//   }

//   void onCaptureOrientationLockButtonPressed() async {
//     try {
//       if (controller != null) {
//         final CameraController cameraController = controller!;
//         if (cameraController.value.isCaptureOrientationLocked) {
//           await cameraController.unlockCaptureOrientation();
//           showInSnackBar('Orientación de captura desbloqueada');
//         } else {
//           await cameraController.lockCaptureOrientation();
//           showInSnackBar(
//               'Orientación de captura bloqueada para ${cameraController.value.lockedCaptureOrientation.toString().split('.').last}');
//         }
//       }
//     } on CameraException catch (e) {
//       _showCameraException(e);
//     }
//   }

//   void onSetFlashModeButtonPressed(FlashMode mode) {
//     setFlashMode(mode).then((_) {
//       if (mounted) setState(() {});
//       showInSnackBar('Flash ${mode.toString().split('.').last}');
//     });
//   }

//   void onSetExposureModeButtonPressed(ExposureMode mode) {
//     setExposureMode(mode).then((_) {
//       if (mounted) setState(() {});
//       showInSnackBar('Modo de exposición ${mode.toString().split('.').last}');
//     });
//   }

//   void onSetFocusModeButtonPressed(FocusMode mode) {
//     setFocusMode(mode).then((_) {
//       if (mounted) setState(() {});
//       showInSnackBar('Enfoque ${mode.toString().split('.').last}');
//     });
//   }

//   Future<void> setFlashMode(FlashMode mode) async {
//     if (controller == null) {
//       return;
//     }

//     try {
//       await controller!.setFlashMode(mode);
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       rethrow;
//     }
//   }

//   Future<void> setExposureMode(ExposureMode mode) async {
//     if (controller == null) {
//       return;
//     }

//     try {
//       await controller!.setExposureMode(mode);
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       rethrow;
//     }
//   }

//   Future<void> setExposureOffset(double offset) async {
//     if (controller == null) {
//       return;
//     }

//     setState(() {
//       _currentExposureOffset = offset;
//     });
//     try {
//       offset = await controller!.setExposureOffset(offset);
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       rethrow;
//     }
//   }

//   Future<void> setFocusMode(FocusMode mode) async {
//     if (controller == null) {
//       return;
//     }

//     try {
//       await controller!.setFocusMode(mode);
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       rethrow;
//     }
//   }

//   Future<XFile?> takePicture() async {
//     final CameraController? cameraController = controller;
//     if (cameraController == null || !cameraController.value.isInitialized) {
//       showInSnackBar('Error. Seleccione primero una camara');
//       return null;
//     }

//     if (cameraController.value.isTakingPicture) {
//       // A capture is already pending, do nothing.
//       return null;
//     }

//     try {
//       XFile file = await cameraController.takePicture();
//       return file;
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       return null;
//     }
//   }

//   Future<int> futureCameras(BuildContext context) async {
//     // Fetch the available cameras before initializing the app.
//     final customCameraProvider = Provider.of<CustomCameraProvider>(context, listen: false);
//     try {
//       customCameraProvider.cameras = await availableCameras();
//       return 200;
//     } on CameraException catch (e) {
//       //logError(e.code, e.description);
//       return 400;
//     }
//   }

//   void _showCameraException(CameraException e) {
//     logError(e.code, e.description);
//     showInSnackBar('Error: ${e.code}\n${e.description}');
//   }
// }
// /// This allows a value of type T or T? to be treated as a value of type T?.
// ///
// /// We use this so that APIs that have become non-nullable can still be used
// /// with `!` and `?` on the stable branch.
// // TODO(ianh): Remove this once we roll stable in late 2021.
// T? _ambiguate<T>(T? value) => value;









// import 'dart:async';
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:prestaprofe/src/providers/providers.dart';
// import 'package:provider/provider.dart';

// // A screen that allows users to take a picture using a given camera.
// class CustomCamera extends StatefulWidget {
//   const CustomCamera({
//     Key? key,
//     required this.camera,
//   }) : super(key: key);

//   final CameraDescription camera;

//   @override
//   CustomCameraState createState() => CustomCameraState();
// }

// class CustomCameraState extends State<CustomCamera> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     // To display the current output from the Camera,
//     // create a CameraController.
//     _controller = CameraController(
//       // Get a specific camera from the list of available cameras.
//       widget.camera,
//       // Define the resolution to use.
//       ResolutionPreset.medium,
//     );

//     // Next, initialize the controller. This returns a Future.
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     // Dispose of the controller when the widget is disposed.
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//         return Scaffold(
//         appBar: AppBar(title: const Text('Take a picture')),
//         // You must wait until the controller is initialized before displaying the
//         // camera preview. Use a FutureBuilder to display a loading spinner until the
//         // controller has finished initializing.
//         body: FutureBuilder<void>(
//           future: _initializeControllerFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               // If the Future is complete, display the preview.
//               return CameraPreview(_controller);
//             } else {
//               // Otherwise, display a loading indicator.
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           // Provide an onPressed callback.
//           onPressed: () async {
//             // Take the Picture in a try / catch block. If anything goes wrong,
//             // catch the error.
//             try {
//               // Ensure that the camera is initialized.
//               await _initializeControllerFuture;
    
//               // Attempt to take a picture and get the file `image`
//               // where it was saved.
//               final image = await _controller.takePicture();
    
//               // If the picture was taken, display it on a new screen.
//               Navigator.pop(context, image);
//             } catch (e) {
//               // If an error occurs, log the error to the console.
//               print(e);
//             }
//           },
//           child: const Icon(Icons.camera_alt),
//         ),
//       );
//   }
// }
