import 'package:flutter/material.dart';
import '../helpers/ad_helper.dart';

class BannerExampleWidget extends StatelessWidget {
  const BannerExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Banner fixo (sempre visível):',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: AdHelper.bannerWidget(
            margin: const EdgeInsets.all(8),
            onError: () => print('Banner falhou'),
          ),
        ),
      ],
    );
  }
} 