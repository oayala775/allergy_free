import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const String screenName = "home_screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CameraController? _controller;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );

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

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonSize = screenSize.width * 0.18; // tamaño del botón
    final borderSize = buttonSize * 0.15; // tamaño del borde exterior

    return Scaffold(
      //appBar: Appbar(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Vista de la cámara que ocupa todo el espacio disponible
            if (_isCameraInitialized && _controller != null)
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: CameraPreview(_controller!),
              )
            else
              const Center(child: CircularProgressIndicator()),

            // Boton
            Positioned(
              bottom: 30,
              left: (screenSize.width - buttonSize) / 2,
              child: Container(
                width: buttonSize + borderSize * 2, // Añade espacio para el borde
                height: buttonSize + borderSize * 2,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: borderSize * 0.4, // Grosor del borde
                  ),
                ),
                child: Center(
                  child: Container(
                    width: buttonSize,
                    height: buttonSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
