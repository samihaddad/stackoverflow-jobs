import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:so_jobs/job.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:html2md/html2md.dart' as html2md;

class JobDetailScreen extends StatefulWidget {
  final Job job;

  const JobDetailScreen({
    Key key,
    this.job,
  }) : super(key: key);

  @override
  _JobDetailScreenState createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  String url;

  @override
  void initState() {
    super.initState();
    url = Uri.dataFromString(widget.job.description,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.job.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Markdown(
                data: html2md.convert(widget.job.description),
              ),
            ),
            RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('View Job')],
              ),
              onPressed: () => launch(widget.job.link),
            )
          ],
        ),
      ),
    );
  }
}
