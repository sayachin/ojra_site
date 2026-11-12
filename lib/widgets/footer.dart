import 'package:flutter/material.dart';

import '../content.dart';
import '../theme.dart';
import 'common.dart';
import 'store_links.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({
    super.key,
    required this.onNavigate,
    required this.onEmail,
    required this.onTop,
  });

  final ValueChanged<String> onNavigate;
  final VoidCallback onEmail;
  final VoidCallback onTop;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF06080F), Color(0xFF030509)],
        ),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.07)),
        ),
      ),
      child: SiteBody(
        padding: const EdgeInsets.only(top: 66, bottom: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (width >= 900)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: _FooterBrand(onEmail: onEmail)),
                  const SizedBox(width: 50),
                  Expanded(
                    child: _FooterColumn(
                      title: 'SERVICES',
                      links: const [
                        ('Mobile apps', 'services'),
                        ('Websites', 'services'),
                        ('E-commerce', 'services'),
                        ('Networking', 'services'),
                        ('Digital solutions', 'services'),
                      ],
                      onNavigate: onNavigate,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: _FooterColumn(
                      title: 'STUDIO',
                      links: const [
                        ('Ojra', 'ojra'),
                        ('Process', 'process'),
                        ('About', 'studio'),
                        ('Contact', 'contact'),
                      ],
                      onNavigate: onNavigate,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 2,
                    child: _FooterContact(
                      onEmail: onEmail,
                      onStartProject: () => onNavigate('contact'),
                    ),
                  ),
                ],
              )
            else ...[
              _FooterBrand(onEmail: onEmail),
              const SizedBox(height: 38),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _FooterColumn(
                      title: 'SERVICES',
                      links: const [
                        ('Mobile apps', 'services'),
                        ('Websites', 'services'),
                        ('E-commerce', 'services'),
                        ('Networking', 'services'),
                      ],
                      onNavigate: onNavigate,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _FooterColumn(
                      title: 'STUDIO',
                      links: const [
                        ('Ojra', 'ojra'),
                        ('Process', 'process'),
                        ('About', 'studio'),
                        ('Contact', 'contact'),
                      ],
                      onNavigate: onNavigate,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _FooterContact(
                onEmail: onEmail,
                onStartProject: () => onNavigate('contact'),
              ),
            ],
            const SizedBox(height: 56),
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 18,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '© ${DateTime.now().year} $kCompanyName',
                        style: T.mono(8, color: Brand.dim, letterSpacing: 0.8),
                      ),
                      Text(
                        'BUILT WITH FLUTTER',
                        style: T.mono(8, color: Brand.dim, letterSpacing: 0.8),
                      ),
                      Text(
                        'IMAGERY VIA UNSPLASH',
                        style: T.mono(8, color: Brand.dim, letterSpacing: 0.8),
                      ),
                      const StoreTextLink(
                        label: 'OJRA RIDER ON GOOGLE PLAY',
                        app: 'Ojra Rider',
                        url: kOjraRiderPlayUrl,
                      ),
                      const StoreTextLink(
                        label: 'OJRA DRIVER ON GOOGLE PLAY',
                        app: 'Ojra Driver',
                        url: kOjraDriverPlayUrl,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                _BackToTop(onTap: onTop),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterBrand extends StatelessWidget {
  const _FooterBrand({required this.onEmail});

  final VoidCallback onEmail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BrandWordmark(markSize: 42),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Text(
            'A digital product studio for the next era. Apps, web, commerce and the networks that connect them.',
            style: T.body(12.5, color: Brand.muted, height: 1.65),
          ),
        ),
        const SizedBox(height: 22),
        Semantics(
          link: true,
          label: 'Email $kContactEmail',
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onEmail,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    kContactEmail,
                    style: T.body(
                      12.5,
                      color: Brand.ink,
                      weight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 7),
                  const Icon(
                    Icons.arrow_outward_rounded,
                    size: 13,
                    color: Brand.cyan,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Brand.line),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Brand.lime,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'AVAILABLE FOR SELECT PROJECTS',
                style: T.mono(7, color: Brand.muted, letterSpacing: 1.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FooterColumn extends StatelessWidget {
  const _FooterColumn({
    required this.title,
    required this.links,
    required this.onNavigate,
  });

  final String title;
  final List<(String, String)> links;
  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: T.mono(8, color: Brand.dim, letterSpacing: 1.7)),
        const SizedBox(height: 17),
        for (final link in links) ...[
          _FooterLink(label: link.$1, onTap: () => onNavigate(link.$2)),
          const SizedBox(height: 11),
        ],
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  const _FooterLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          behavior: HitTestBehavior.opaque,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            style: T.body(
              12.5,
              weight: FontWeight.w400,
              color: _hovered ? Brand.ink : Brand.muted,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.label),
                if (_hovered) ...[
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.north_east_rounded,
                    size: 10,
                    color: Brand.cyan,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterContact extends StatelessWidget {
  const _FooterContact({required this.onEmail, required this.onStartProject});

  final VoidCallback onEmail;
  final VoidCallback onStartProject;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GET IN TOUCH',
          style: T.mono(8, color: Brand.dim, letterSpacing: 1.7),
        ),
        const SizedBox(height: 17),
        Text(
          'Have a product in mind?',
          style: T.body(
            13,
            color: Brand.ink,
            weight: FontWeight.w600,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Tell us where you want to go.',
          style: T.body(12, color: Brand.muted, height: 1.5),
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: onStartProject,
          borderRadius: BorderRadius.circular(7),
          hoverColor: Brand.cyan.withValues(alpha: 0.06),
          splashColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Brand.lineStrong),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Start a project',
                  style: T.body(
                    11.5,
                    color: Brand.ink,
                    weight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 7),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 12,
                  color: Brand.cyan,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        Semantics(
          link: true,
          label: 'Email $kContactEmail',
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onEmail,
              child: Text(
                kContactEmail,
                style: T.mono(8, color: Brand.muted, letterSpacing: 0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BackToTop extends StatefulWidget {
  const _BackToTop({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_BackToTop> createState() => _BackToTopState();
}

class _BackToTopState extends State<_BackToTop> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Back to top',
      child: Semantics(
        button: true,
        label: 'Back to top',
        child: InkWell(
          onTap: widget.onTap,
          onHover: (v) => setState(() => _hovered = v),
          borderRadius: BorderRadius.circular(30),
          hoverColor: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hovered
                  ? Brand.cyan.withValues(alpha: 0.08)
                  : Colors.transparent,
              border: Border.all(
                color: _hovered
                    ? Brand.cyan.withValues(alpha: 0.4)
                    : Brand.lineStrong,
              ),
            ),
            child: Icon(
              Icons.arrow_upward_rounded,
              size: 15,
              color: _hovered ? Brand.cyan : Brand.muted,
            ),
          ),
        ),
      ),
    );
  }
}
