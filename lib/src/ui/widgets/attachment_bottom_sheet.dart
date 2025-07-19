import 'package:chatgpt_clone/src/core/assets/svg_assets.dart';
import 'package:chatgpt_clone/src/ui/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

class AttachmentBottomSheet extends StatelessWidget {
  const AttachmentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconTile(
                label: 'Camera',
                svg: SVGs.camera(),
                onTap: () {},
              ),
              IconTile(
                label: 'Photos',
                svg: SVGs.photos(),
                onTap: () {},
              ),
              IconTile(
                label: 'Files',
                svg: SVGs.folder(),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.grey, thickness: 0.5),
          CustomListTile(
            svg: SVGs.telescope(),
            label: "Deep research",
            onTap: () {},
          ),
          CustomListTile(
            svg: SVGs.lightbulb(),
            label: "Think for longer",
            onTap: () {},
          ),
          CustomListTile(
              svg: SVGs.settings(), label: "Create image", onTap: () {}),
          CustomListTile(
            svg: SVGs.globe(),
            label: "Web search",
            onTap: () {},
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class IconTile extends StatelessWidget {
  final String label;
  final Widget svg;
  final VoidCallback? onTap;
  const IconTile(
      {super.key, required this.label, required this.svg, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          svg,
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
