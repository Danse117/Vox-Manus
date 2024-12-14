import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';


class ShowLabels extends StatelessWidget {
  final List<ImageLabel> labels;
  final double top;
  final double left;
  final double right;
  const ShowLabels({super.key, required this.labels, required this.top, required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return Positioned(
                      top: top,
                      left: left,
                      right: right,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        color: Colors.black54,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: labels
                              .map((label) => Text(
                                    '${label.label}: ${(label.confidence * 100).toStringAsFixed(1)}%',
                                    style: const TextStyle(color: Colors.white),
                                  ))
                              .toList(),
                        ),
      ),
    );
  }
}