// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import '../../widgets/widgets.dart';

// class HomeScreen extends StatefulWidget {
//   static const String screenName = "home_screen";
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   CameraController? _controller;
//   bool _isCameraInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     try {
//       final cameras = await availableCameras();
//       final firstCamera = cameras.first;

//       _controller = CameraController(firstCamera, ResolutionPreset.medium);

//       await _controller!.initialize();

//       if (mounted) {
//         setState(() {
//           _isCameraInitialized = true;
//         });
//       }
//     } catch (e) {
//       print('Error initializing camera: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final buttonSize = screenSize.width * 0.18; // tamaño del botón
//     final borderSize = buttonSize * 0.15; // tamaño del borde exterior

//     return Scaffold(
//       //appBar: Appbar(),
//       body: SizedBox(
//         width: double.infinity,
//         height: double.infinity,
//         child: Stack(
//           fit: StackFit.passthrough,
//           children: [
//             // Vista de la cámara que ocupa todo el espacio disponible
//             if (_isCameraInitialized && _controller != null)
//               FittedBox(
//                 fit: BoxFit.fill,
//                 child: SizedBox(
//                   width: _controller!.value.previewSize!.width,
//                   height: _controller!.value.previewSize!.height,
//                   // width: double.infinity,
//                   // height: double.infinity,
//                   child: CameraPreview(_controller!),
//                 ),
//               )
//             else
//               const Center(child: CircularProgressIndicator()),

//             // Boton
//             Positioned(
//               bottom: 30,
//               left: (screenSize.width - buttonSize) / 2,
//               child: Container(
//                 width:
//                     buttonSize + borderSize * 2, // Añade espacio para el borde
//                 height: buttonSize + borderSize * 2,
//                 decoration: BoxDecoration(
//                   color: Colors.transparent,
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: Colors.white,
//                     width: borderSize * 0.4, // Grosor del borde
//                   ),
//                 ),
//                 child: Center(
//                   child: Container(
//                     width: buttonSize,
//                     height: buttonSize,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const Navbar(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:ui'; // Para BackdropFilter

import '../../widgets/widgets.dart';
// import './ocr_results_screen.dart'; // Importa la nueva pantalla

class HomeScreen extends StatefulWidget {
  static const String screenName = "home_screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  bool _isProcessing = false; // Nuevo estado para el indicador de carga

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // ... (esta función no cambia)
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;
      _controller = CameraController(firstCamera, ResolutionPreset.high);
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  // 👇👇 LÓGICA DE CAPTURA Y OCR 👇👇
  Future<void> _onCaptureAndProcess() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    setState(() {
      _isProcessing = true; // Muestra el indicador de carga
    });

    try {
      // 1. Tomar la foto
      final XFile imageFile = await _controller!.takePicture();

      // 2. Preparar la imagen para ML Kit
      final inputImage = InputImage.fromFilePath(imageFile.path);

      // 3. Crear una instancia del reconocedor de texto
      final textRecognizer = TextRecognizer();

      // 4. Procesar la imagen para encontrar texto
      final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );

      // 5. Cerrar el reconocedor para liberar recursos
      await textRecognizer.close();

      // 6. Navegar a la pantalla de resultados
      if (mounted) {
        print(recognizedText.text);
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => OcrResultsScreen(
        //       extractedText: recognizedText.text,
        //     ),
        //   ),
        // );
      }
    } catch (e) {
      print('Error durante el proceso de OCR: $e');
    } finally {
      setState(() {
        _isProcessing = false; // Oculta el indicador de carga
      });
    }
  }

  Future<void> _onFocusButtonPressed() async {
    // ... (esta función no cambia)
    if (_controller == null) return;
    try {
      await _controller!.setFocusMode(FocusMode.auto);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enfocando...'),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.black54,
          ),
        );
      }
    } catch (e) {
      print('Error al establecer el modo de enfoque: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonSize = screenSize.width * 0.18;
    final borderSize = buttonSize * 0.15;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Vista de la cámara
          if (_isCameraInitialized && _controller != null)
            FittedBox(
              fit: BoxFit.fill,
              child: SizedBox(
                width: _controller!.value.previewSize!.width,
                height: _controller!.value.previewSize!.height,
                child: CameraPreview(_controller!),
              ),
            )
          else
            const Center(child: CircularProgressIndicator()),

          // Botón de enfoque
          Positioned(
            top: 50.0,
            right: 20.0,
            child: IconButton(
              onPressed: _onFocusButtonPressed,
              icon: const Icon(Icons.filter_center_focus),
              iconSize: 40.0,
              color: Colors.white,
            ),
          ),

          // Botón de captura (ahora es un GestureDetector)
          Positioned(
            bottom: 30,
            left: (screenSize.width - (buttonSize + borderSize * 2)) / 2,
            child: GestureDetector(
              onTap:
                  _isProcessing
                      ? null
                      : _onCaptureAndProcess, // Llama a la nueva función
              child: Container(
                width: buttonSize + borderSize * 2,
                height: buttonSize + borderSize * 2,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: borderSize * 0.4,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: buttonSize,
                    height: buttonSize,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 👇👇 INDICADOR DE CARGA MIENTRAS SE PROCESA 👇👇
          if (_isProcessing)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 20),
                    Text(
                      'Reconociendo texto...',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
