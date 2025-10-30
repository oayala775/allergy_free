import 'dart:ui';
import 'package:allergy_free/config/utils/helpers/results_state.dart';
import 'package:allergy_free/presentation/screens/results/results_screen.dart';
import 'package:allergy_free/presentation/widgets/widgets.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class HomeScreen extends StatefulWidget {
  static const String screenName = "home_screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
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

  Future<void> _onCaptureAndProcess() async {
    // if (_controller == null || !_controller!.value.isInitialized) return;

    setState(() {
      _isProcessing = true; // Muestra el indicador de carga
    });

    try {
      // 1. Takes picture
      final XFile imageFile = await _controller!.takePicture();

      // 2. Prepares image to prepare it for GoogleMLKit
      final inputImage = InputImage.fromFilePath(imageFile.path);

      final textRecognizer = TextRecognizer();

      // 3. Process image to recognize text
      final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );

      // 4. Close recognizer to free up resources
      await textRecognizer.close();

      if (mounted) {
        final ResultsState resultsState = ResultsState(
          isAllergenFree: false,
          isUnrecognizedText: true,
        );
        GoRouter.of(
          context,
        ).goNamed(ResultsScreen.screenName, extra: resultsState);
        print(recognizedText.text);
      }
    } catch (e) {
      print('Error durante el proceso de OCR: $e');
    } finally {
      setState(() {
        _isProcessing = false; // Hides the charging indicator
      });
    }
  }

  Future<void> _onFocusButtonPressed() async {
    if (_controller == null) return;
    try {
      await _controller!.setFocusMode(FocusMode.auto);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Focusing...'),
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

          Positioned(
            bottom: 30,
            left: (screenSize.width - (buttonSize + borderSize * 2)) / 2,
            child: Center(
              child: GestureDetector(
                onTap: _isProcessing ? null : _onCaptureAndProcess,
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
          ),

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
