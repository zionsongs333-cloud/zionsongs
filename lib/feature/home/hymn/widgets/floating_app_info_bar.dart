import 'package:flutter/material.dart';

class FloatingAppInfoBar extends StatelessWidget {
  final bool visible;
  final VoidCallback? onToggle;

  const FloatingAppInfoBar({
    super.key,
    this.visible = true,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      top: visible ? 0 : -72,
      left: 0,
      right: 0,
      child: Material(
        elevation: 4,
        color: Colors.transparent,
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor.withAlpha((0.96 * 255).round()),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.library_music, size: 26),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Zion Songs',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: Icon(visible ? Icons.visibility : Icons.visibility_off),
                tooltip: visible ? 'Hide app bar' : 'Show app bar',
                onPressed: onToggle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
