import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget svg;
  final String label;
  final VoidCallback? onTap;
  const CustomListTile(
      {super.key, required this.svg, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
      leading: svg,
      title: Text(label,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
      onTap: onTap,
    );
  }
}
