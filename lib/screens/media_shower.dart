import 'package:dr_abdelhameed/widgets/custom_video_player.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class VideoShow extends StatefulWidget {
  final String dataType;
  final String url;
  const VideoShow({super.key, required this.url, required this.dataType});

  @override
  State<VideoShow> createState() => _VideoShowState();
}

class _VideoShowState extends State<VideoShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: Center(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: (widget.dataType == 'Video')
                ? DefaultPlayer(
                    url: widget.url,
                  )
                : SfPdfViewer.network(widget.url),
          ),
        ));
  }
}
