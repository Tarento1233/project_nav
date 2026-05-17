// features/auth/widgets/auth_banner.dart

import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';

class AuthBanner extends StatelessWidget {
  final String imageUrl;

  const AuthBanner({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.xl),

      child: Image.network(
        imageUrl,

        width: double.infinity,

        height: 220,

        fit: BoxFit.cover,
      ),
    );
  }
}
