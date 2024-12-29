// import 'package:flutter/material.dart';
// import '_mobile_application/qr_code_scanner.dart';
//
// class QRCodeScreen extends StatefulWidget {
//   @override
//   _QRCodeScreenState createState() => _QRCodeScreenState();
// }
//
// class _QRCodeScreenState extends State<QRCodeScreen> {
//   GlobalKey qrKey = GlobalKey();
//   var qrText = "";
//   QRViewController controller;
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 5,
//       child: QRView(
//         key: qrKey,
//         overlay: QrScannerOverlayShape(
//             borderRadius: 10,
//             borderColor: Colors.red,
//             borderLength: 30,
//             borderWidth: 10,
//             cutOutSize: 300
//         ),
//         onQRViewCreated: _onQRViewCreate,
//       ),
//     );
//   }
//
//   void _onQRViewCreate(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         qrText = scanData.toString();
//       });
//     });
//   }
// }
