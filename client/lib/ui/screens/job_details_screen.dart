import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:so_jobs/core/models/job.dart';
import 'package:url_launcher/url_launcher.dart';
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
      body: Column(
        children: [
          Expanded(
            child: Markdown(
              data: html2md.convert(widget.job.description),
            ),
          ),
          RaisedButton(
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'View Job',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () => launch(widget.job.link),
          )
        ],
      ),
    );
  }
}
