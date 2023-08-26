import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iot_wifi/flutter_iot_wifi.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'dart:convert' show json, utf8;
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => ListPage(),
      },
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<WiFiAccessPoint> accessPoints = <WiFiAccessPoint>[];
  StreamSubscription<List<WiFiAccessPoint>>? subscription;
  bool shouldCheckCan = true;

  bool get isStreaming => subscription != null;

  Future<void> _startScan(BuildContext context) async {
    // check if "can" startScan
    if (shouldCheckCan) {
      // check if can-startScan
      final can = await WiFiScan.instance.canStartScan();
      // if can-not, then show error
      if (can != CanStartScan.yes) {
        if (mounted) kShowSnackBar(context, "Cannot start scan: $can");
        return;
      }
    }

    // call startScan API
    final result = await WiFiScan.instance.startScan();
    if (mounted) kShowSnackBar(context, "startScan: $result");
    // reset access points.
    setState(() => accessPoints = <WiFiAccessPoint>[]);
  }

  Future<bool> _canGetScannedResults(BuildContext context) async {
    if (shouldCheckCan) {
      // check if can-getScannedResults
      final can = await WiFiScan.instance.canGetScannedResults();
      // if can-not, then show error
      if (can != CanGetScannedResults.yes) {
        if (mounted) kShowSnackBar(context, "Cannot get scanned results: $can");
        accessPoints = <WiFiAccessPoint>[];
        return false;
      }
    }
    return true;
  }

  Future<void> _getScannedResults(BuildContext context) async {
    if (await _canGetScannedResults(context)) {
      // get scanned results
      final results = await WiFiScan.instance.getScannedResults();
      setState(() => accessPoints = results);
    }
  }

  Future<void> _startListeningToScanResults(BuildContext context) async {
    if (await _canGetScannedResults(context)) {
      subscription = WiFiScan.instance.onScannedResultsAvailable
          .listen((result) => setState(() => accessPoints = result));
    }
  }

  void _stopListeningToScanResults() {
    subscription?.cancel();
    setState(() => subscription = null);
  }

  @override
  void dispose() {
    super.dispose();
    // stop subscription for scanned results
    _stopListeningToScanResults();
  }

  // build toggle with label
  Widget _buildToggle({
    String? label,
    bool value = false,
    ValueChanged<bool>? onChanged,
    Color? activeColor,
  }) =>
      Row(
        children: [
          if (label != null) Text(label),
          Switch(value: value, onChanged: onChanged, activeColor: activeColor),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
          actions: [
            _buildToggle(
                label: "Check can?",
                value: shouldCheckCan,
                onChanged: (v) => setState(() => shouldCheckCan = v),
                activeColor: Colors.purple)
          ],
        ),
        body: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.perm_scan_wifi),
                      label: const Text('SCAN'),
                      onPressed: () async => _startScan(context),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.refresh),
                      label: const Text('GET'),
                      onPressed: () async => _getScannedResults(context),
                    ),
                    _buildToggle(
                      label: "STREAM",
                      value: isStreaming,
                      onChanged: (shouldStream) async => shouldStream
                          ? await _startListeningToScanResults(context)
                          : _stopListeningToScanResults(),
                    ),
                  ],
                ),
                const Divider(),
                Flexible(
                  child: Center(
                    child: accessPoints.isEmpty
                        ? const Text("NO SCANNED RESULTS")
                        : ListView.builder(
                            itemCount: accessPoints.length,
                            itemBuilder: (context, i) {
                              String ssid = accessPoints[i].ssid;
                              if (ssid.contains('SGM')) {
                                return _AccessPointTile(
                                    accessPoint: accessPoints[i]);
                              }
                              {
                                return Container();
                              }
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AccessPointTile extends StatelessWidget {
  final WiFiAccessPoint accessPoint;

  const _AccessPointTile({Key? key, required this.accessPoint})
      : super(key: key);

  Future<bool> _checkPermissions() async {
    if (Platform.isIOS || await Permission.location.request().isGranted) {
      return true;
    }
    return false;
  }

  void _connect(String red, String pass) async {
    if (await _checkPermissions()) {
      FlutterIotWifi.connect(red, pass, prefix: true).then((value) {
        if (value!) {
          enviarCredenciales('Flutter', 'password');
        } else {
          print('Error de conexión');
        }
      });
    } else {
      print("don't have permission");
    }
  }

  Future<void> enviarCredenciales(String ssid, String password) async {
    final url =
        Uri.parse('http://esp32.local/connect'); // URL del servidor en el ESP32
    final response = await http.post(url, body: {
      'ssid': ssid,
      'password': password,
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print('Mensaje: ${jsonResponse["message"]}');
      print('Estado: ${jsonResponse["status"]}');
    } else {
      print('Error al enviar las credenciales');
    }
  }

  Future<void> sendCredentials() async {
    var request =
        http.MultipartRequest('POST', Uri.parse('http://esp32.local/connect'));
    request.fields.addAll({'ssid': 'RedCasa', 'password': 'B67D76P01A04'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  // build row that can display info, based on label: value pair.
  Widget _buildInfo(String label, dynamic value) => Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        child: Row(
          children: [
            Text(
              "$label: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(child: Text(value.toString()))
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final title = accessPoint.ssid.isNotEmpty ? accessPoint.ssid : "**EMPTY**";
    final signalIcon = accessPoint.level >= -80
        ? Icons.signal_wifi_4_bar
        : Icons.signal_wifi_0_bar;
    return ListTile(
      visualDensity: VisualDensity.compact,
      leading: Icon(signalIcon),
      title: Text(title),
      subtitle: Text(accessPoint.capabilities),
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _connect(accessPoint.ssid, 'password');
                  },
                  child: Text('Conectar'))
            ],
          ),
        ),
      ),
    );
  }
}

/// Show snackbar.
void kShowSnackBar(BuildContext context, String message) {
  if (kDebugMode) print(message);
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

//CONNECTION
class AccessPointWidget extends StatelessWidget {
  const AccessPointWidget({Key? key}) : super(key: key);

  final String ssid = "ESP32_PAUL"; // TODO replace with your ssid
  final String password = "password"; // TODO replace with your password

  Future<bool> _checkPermissions() async {
    if (Platform.isIOS || await Permission.location.request().isGranted) {
      return true;
    }
    return false;
  }

  void _connect(String red, String pass) async {
    if (await _checkPermissions()) {
      FlutterIotWifi.connect(ssid, password, prefix: true)
          .then((value) => print("connect initiated: $value"));
    } else {
      print("don't have permission");
    }
  }

  void _disconnect() async {
    if (await _checkPermissions()) {
      FlutterIotWifi.disconnect()
          .then((value) => print("disconnect initiated: $value"));
    } else {
      print("don't have permission");
    }
  }

  void _scan() async {
    if (await _checkPermissions()) {
      FlutterIotWifi.scan().then((value) => print("scan started: $value"));
    } else {
      print("don't have permission");
    }
  }

  void _list() async {
    if (await _checkPermissions()) {
      FlutterIotWifi.list().then((value) => print("ssids: $value"));
    } else {
      print("don't have permission");
    }
  }

  void _current() async {
    if (await _checkPermissions()) {
      FlutterIotWifi.current().then((value) => print("current ssid: $value"));
    } else {
      print("don't have permission");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(child: Text("SSID: $ssid, PASSWORD: $password")),
        //_CustomButton(onPressed: _connect, child: const Text("Connect")),
        _CustomButton(onPressed: _disconnect, child: const Text("Disconnect")),
        _CustomButton(
            onPressed: _scan, child: const Text("Scan (Android only)")),
        _CustomButton(
            onPressed: _list, child: const Text("List (Android only)")),
        _CustomButton(onPressed: _current, child: const Text("Current")),
      ],
    );
  }
}

class _CustomButton extends StatelessWidget {
  const _CustomButton({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40, child: ElevatedButton(onPressed: onPressed, child: child));
  }
}
