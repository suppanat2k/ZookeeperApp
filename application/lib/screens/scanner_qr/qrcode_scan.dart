import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:zookeeper_app/bloc/qrscan_bloc/qrscan_bloc.dart';
import 'package:zookeeper_app/screens/other/loading_widget.dart';
import 'package:zookeeper_app/screens/scanner_qr/scan_components/ticket_component.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isFlashOpen = false;
  bool isCameraReady = true;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: BlocListener<QrscanBloc, QrscanState>(
              listener: (context, state) {
                if (state is QrscanLoding) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) =>
                        LoadingWidget().loadingList(context),
                  );
                }
                if (state is QrscanFailed) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text("Something wrong.."),
                    backgroundColor: Colors.red,
                  ));
                  Navigator.pop(context);
                }
                if (state is QrscanLoaded) {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => TicketScanComponent()
                          .ticketScanComponent(
                              context, state.getTicketScanModel));
                }
                if (state is QrscanSuccess) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text("Ticket has accept!"),
                    backgroundColor: Colors.green,
                  ));
                  setState(() {
                    isCameraReady = true;
                  });
                }
              },
              child: Column(
                children: <Widget>[
                  Expanded(flex: 9, child: _buildQrView(context)),
                  Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  await controller?.toggleFlash();
                                  if (isFlashOpen == false) {
                                    isFlashOpen = true;
                                  } else {
                                    isFlashOpen = false;
                                  }
                                },
                                icon: Image.asset(
                                  isFlashOpen
                                      ? "assets/images/icons/flash.png"
                                      : "assets/images/icons/no-flash.png",
                                  width: 40,
                                )),
                            IconButton(
                                onPressed: () async {
                                  await controller?.flipCamera();
                                  setState(() {});
                                },
                                icon: Image.asset(
                                  "assets/images/icons/camera-flip.png",
                                  width: 40,
                                )),
                            IconButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 40,
                                ))
                          ],
                        ),
                      ))
                ],
              ))),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          overlayColor: Colors.white,
          borderColor: Colors.black,
          borderRadius: 5,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });

      if (isCameraReady) {
        setState(() {
          isCameraReady = false;
        });
        context.read<QrscanBloc>().add(QrscanFoundCode(result!.code.toString()));
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
