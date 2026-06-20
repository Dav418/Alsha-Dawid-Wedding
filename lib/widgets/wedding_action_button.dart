import 'package:flutter/material.dart';

import '../utils/extension/context_extension.dart';

/// Primary call-to-action button used across FAQ, RSVP, home, etc.
class WeddingActionButton extends StatelessWidget {
  const WeddingActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.minimumSize = const Size(168, 44),
  });

  final String label;
  final VoidCallback? onPressed;
  final Size minimumSize;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: minimumSize,
        padding: const EdgeInsets.symmetric(horizontal: 28),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: context.buttonLabel(),
      ),
    );
  }
}
