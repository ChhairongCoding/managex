import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stockmanagement/src/feature/scan/view/widgets/product_scan_modal.dart';
import 'package:stockmanagement/src/feature/scan/view/widgets/scanner_overlay_painter_widget.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    facing: CameraFacing.back,
  );

  bool isScanned = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (isScanned) return;

    final barcode = capture.barcodes.first.rawValue;

    if (barcode != null) {
      setState(() => isScanned = true);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Scanned: $barcode")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Stack(
        children: [
          /// Camera
          MobileScanner(controller: controller, onDetect: _onDetect),

          /// Overlay with cutout
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: ScannerOverlayPainter(),
          ),

          /// Top text
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: Colors.white),
                  ),
                ),
                Text(
                  "Scan QR / Barcode",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  child: Badge(
                    label: Text("0"),
                    child: IconButton(
                      onPressed: () => showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => ProductScanModal(),
                      ),
                      icon: Icon(Icons.shopping_bag, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Flash
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Center(
              child: ValueListenableBuilder(
                valueListenable: controller,

                builder: (_, state, __) {
                  return IconButton(
                    onPressed: controller.toggleTorch,
                    icon: Icon(
                      state.torchState == TorchState.on
                          ? Icons.flash_on
                          : Icons.flash_off,
                      color: Colors.white,
                      size: 32,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
