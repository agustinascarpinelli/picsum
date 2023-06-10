import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class RowDetail extends StatefulWidget {
  const RowDetail({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    this.icon = false,
    this.url,
    this.downloadPic = false,
    this.downloadPicUrl,
  });

  final String title;
  final String subtitle;
  final Color color;
  final bool? icon;
  final String? url;
  final bool? downloadPic;
  final String? downloadPicUrl;

  @override
  State<RowDetail> createState() => _RowDetailState();
}

class _RowDetailState extends State<RowDetail> {
  void _dowloadFile(String url) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();
      final id = await FlutterDownloader.enqueue(
        url: url,
        showNotification: true,
        openFileFromNotification: true,
        fileName: 'PICSUM',
        savedDir: baseStorage!.path,
      );
    } else {
      return;
    }
  }

  int progress = 0;
  bool isLoading = false;
  ReceivePort receivePort = ReceivePort();

  @override
  void initState() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, "downloading");

    receivePort.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus(data[1]);
      progress = data[2];
      setState(() {
        progress = data[2];
      });
    });
    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping("downloading");
    super.dispose();
  }

  @pragma('vm:entry-point')
  static downloadCallback(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");
    sendPort!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: widget.icon == true
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
              widget.title,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: widget.color),
            )),
            Expanded(
                child: Text(widget.subtitle,
                    style: TextStyle(fontSize: 15, color: widget.color))),
            if (widget.icon == true)
              IconButton(
                icon: const Icon(Icons.open_in_new),
                onPressed: () async {
                  final uri = Uri.parse(widget.url!);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    AlertDialog(title: Text('Cannot launch url ${widget.url}'));
                  }
                },
              ),
            if (widget.downloadPic == true)
              IconButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    _dowloadFile(widget.downloadPicUrl!);
                    await Future.delayed(const Duration(milliseconds: 15000));
                    setState(() {
                      isLoading = false;
                    });
                  },
                  icon: isLoading
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.file_download_outlined))
          ],
        ),
      ),
    );
  }
}
