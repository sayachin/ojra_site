import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';

class StudioSection extends StatelessWidget {
  const StudioSection({super.key, required this.onStartProject});

  final VoidCallback onStartProject;

  @override
  Widget build(BuildContext context) {
    return SiteBody(
      padding: const EdgeInsets.symmetric(vertical: 112),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final desktop = constraints.maxWidth >= 940;
          final image = _StudioImage(desktop: desktop);
          final content = _StudioContent(
            onStartProject: onStartProject,
            compact: !desktop,
          );
          if (desktop) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: image),
                const SizedBox(width: 60),
                Expanded(flex: 6, child: content),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [content, const SizedBox(height: 44), image],
          );
        },
      ),
    );
  }
}

class _StudioImage extends StatelessWidget {
  const _StudioImage({required this.desktop});

  final bool desktop;

  @override
  Widget build(BuildContext context) {
    final height = desktop ? 590.0 : 340.0;
    return Reveal(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Brand.line),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 60,
              spreadRadius: -20,
              offset: const Offset(0, 28),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/studio_stage.jpg',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
                semanticLabel: 'A modern, empty studio interior',
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x2205070E), Color(0xE605070E)],
                    stops: [0.15, 1],
                  ),
                ),
              ),
              Positioned(
                top: 18,
                left: 18,
                child: GlassPill(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Brand.cyan,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        'NEW AGE FACTORIES / STUDIO',
                        style: T.mono(
                          7.5,
                          color: const Color(0xFFD7E1F0),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 23,
                right: 22,
                child: Text(
                  '04',
                  style: T.mono(8, color: Brand.muted, letterSpacing: 1.3),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xD90A0F18),
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.11),
                    ),
                  ),
                  child: Row(
                    children: [
                      const BrandMark(size: 34),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Built in-house. Built to last.',
                              style: T.body(
                                12.5,
                                weight: FontWeight.w600,
                                color: Brand.ink,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Design, engineering and everything between.',
                              style: T.body(
                                10.5,
                                color: Brand.muted,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Brand.lineStrong),
                        ),
                        child: const Icon(
                          Icons.arrow_outward_rounded,
                          size: 13,
                          color: Brand.cyan,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StudioContent extends StatelessWidget {
  const _StudioContent({required this.onStartProject, required this.compact});

  final VoidCallback onStartProject;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = compact ? (width < 420 ? 37.0 : 42.0) : 49.0;
    const principles = <(IconData, String, String, Color)>[
      (
        Icons.account_tree_outlined,
        'End-to-end ownership',
        'Strategy, design, engineering and launch stay in one line.',
        Brand.cyan,
      ),
      (
        Icons.layers_outlined,
        'Systems thinking',
        'We build for scale and maintenance, not just the demo.',
        Brand.violet,
      ),
      (
        Icons.forum_outlined,
        'Direct collaboration',
        'One senior team, clear communication, no telephone game.',
        Brand.blue,
      ),
      (
        Icons.all_inclusive_rounded,
        'Long-term partnership',
        'We stay for the road after launch, not just the release.',
        Brand.lime,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Reveal(child: SectionEyebrow('04', 'The studio')),
        const SizedBox(height: 30),
        Reveal(
          delay: const Duration(milliseconds: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A product partner,',
                style: T.display(titleSize, height: 1.04),
              ),
              GradientText(
                'not a task factory.',
                style: T.display(titleSize, height: 1.04),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Reveal(
          delay: const Duration(milliseconds: 120),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 570),
            child: Text(
              'New Age Factories is a compact, senior team. You work directly with the people designing and building your product — across apps, web, commerce and the networks underneath.',
              style: T.body(15, color: Brand.muted, height: 1.7),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Reveal(
          delay: const Duration(milliseconds: 180),
          child: Column(
            children: [
              for (var i = 0; i < principles.length; i++) ...[
                _PrincipleRow(
                  icon: principles[i].$1,
                  title: principles[i].$2,
                  description: principles[i].$3,
                  color: principles[i].$4,
                ),
                if (i < principles.length - 1)
                  Divider(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 30),
        Reveal(
          delay: const Duration(milliseconds: 240),
          child: Wrap(
            spacing: 18,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              NafButton(
                label: 'Work with us',
                style: NafButtonStyle.outline,
                onPressed: onStartProject,
              ),
              Text(
                'DESIGN + ENGINEERING / IN-HOUSE',
                style: T.mono(8, color: Brand.dim, letterSpacing: 1.3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrincipleRow extends StatelessWidget {
  const _PrincipleRow({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.16)),
            ),
            child: Icon(icon, size: 14, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: T.body(
                    13,
                    weight: FontWeight.w600,
                    color: Brand.ink,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: T.body(12, color: Brand.muted, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
