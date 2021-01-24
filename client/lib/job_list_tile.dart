import 'package:flutter/material.dart';
import 'package:so_jobs/job.dart';
import 'package:timeago/timeago.dart' as timeago;

class JobListTile extends StatelessWidget {
  const JobListTile({
    Key key,
    @required this.job,
    this.onTap,
  }) : super(key: key);

  final Job job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsetsDirectional.only(start: 4, end: 16, top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/stackoverflow.png',
              width: 40,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    timeago.format(job.publishDate),
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Text(job.company ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.grey[300])),
                Text(job.location ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
