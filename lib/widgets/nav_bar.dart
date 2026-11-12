import 'package:flutter/material.dart';

import '../theme.dart';
import 'common.dart';

class SiteNav extends StatefulWidget {
  const SiteNav({
    super.key,
    required this.scrollController,
    required this.onNavigate,
    required this.onStartProject,
  });

  final ScrollController scrollController;
  final ValueChanged<String> onNavigate;
  final VoidCallback onStartProject;

  @override
  State<SiteNav> createState() => _SiteNavState();
}

class _SiteNavState extends State<SiteNav> {
  static const _links = <({String id, String label})>[
    (id: 'services', label: 'Services'),
    (id: 'ojra', label: 'Ojra'),
    (id: 'process', label: 'Process'),
    (id: 'studio', label: 'Studio'),
    (id: 'contact', label: 'Contact'),
  ];

  bool _scrolled = false;
  bool _menuOpen = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
    _onScroll();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final next =
        widget.scrollController.hasClients &&
        widget.scrollController.offset > 24;
    if (next != _scrolled && mounted) setState(() => _scrolled = next);
  }

  void _go(String id) {
    if (_menuOpen) setState(() => _menuOpen = false);
    widget.onNavigate(id);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 1024;
    final navHeight = compact ? 68.0 : 78.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOut,
          height: navHeight,
          decoration: BoxDecoration(
            color: _scrolled || _menuOpen
                ? const Color(0xFF070A12)
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: _scrolled || _menuOpen
                    ? Colors.white.withValues(alpha: 0.07)
                    : Colors.transparent,
              ),
            ),
          ),
          child: SiteBody(
            maxWidth: 1320,
            child: Row(
              children: [
                _Logo(onTap: () => _go('home')),
                const Spacer(),
                if (!compact) ...[
                  Row(
                    children: [
                      for (var i = 0; i < _links.length; i++) ...[
                        _NavLink(
                          label: _links[i].label,
                          onTap: () => _go(_links[i].id),
                        ),
                        if (i < _links.length - 1) const SizedBox(width: 30),
                      ],
                    ],
                  ),
                  const SizedBox(width: 34),
                  NafButton(
                    label: 'Start a project',
                    compact: true,
                    onPressed: widget.onStartProject,
                  ),
                ] else
                  _MenuToggle(
                    open: _menuOpen,
                    onTap: () => setState(() => _menuOpen = !_menuOpen),
                  ),
              ],
            ),
          ),
        ),
        if (compact)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: _menuOpen
                ? _MobileMenu(
                    key: const ValueKey('menu'),
                    links: _links,
                    onNavigate: _go,
                    onStartProject: () {
                      setState(() => _menuOpen = false);
                      widget.onStartProject();
                    },
                  )
                : const SizedBox.shrink(key: ValueKey('closed')),
          ),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'New Age Factories home',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: const BrandWordmark(markSize: 34),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 180),
                  style: T.body(
                    13,
                    weight: FontWeight.w500,
                    color: _hovered ? Brand.ink : const Color(0xFFAAB4C6),
                  ),
                  child: Text(widget.label),
                ),
                const SizedBox(height: 5),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 1,
                  width: _hovered ? 18 : 0,
                  decoration: const BoxDecoration(gradient: Brand.signature),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuToggle extends StatelessWidget {
  const _MenuToggle({required this.open, required this.onTap});

  final bool open;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: open ? 'Close menu' : 'Open menu',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: Brand.lineStrong),
              color: Colors.white.withValues(alpha: 0.03),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: Icon(
                open ? Icons.close_rounded : Icons.menu_rounded,
                key: ValueKey(open),
                size: 20,
                color: Brand.ink,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  const _MobileMenu({
    super.key,
    required this.links,
    required this.onNavigate,
    required this.onStartProject,
  });

  final List<({String id, String label})> links;
  final ValueChanged<String> onNavigate;
  final VoidCallback onStartProject;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      width: double.infinity,
      height: height - 68,
      decoration: const BoxDecoration(
        color: Color(0xFF070A12),
        border: Border(top: BorderSide(color: Color(0x14FFFFFF))),
      ),
      child: SiteBody(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 36, bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NAVIGATION',
                style: T.mono(9.5, color: Brand.dim, letterSpacing: 2.2),
              ),
              const SizedBox(height: 20),
              for (var i = 0; i < links.length; i++)
                _MobileLink(
                  index: '0${i + 1}',
                  label: links[i].label,
                  onTap: () => onNavigate(links[i].id),
                ),
              const SizedBox(height: 32),
              NafButton(label: 'Start a project', onPressed: onStartProject),
              const SizedBox(height: 40),
              Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
              const SizedBox(height: 24),
              Text(
                'NEW AGE FACTORIES LLC',
                style: T.mono(9, color: Brand.dim, letterSpacing: 1.8),
              ),
              const SizedBox(height: 8),
              Text(
                'Digital products, built end to end.',
                style: T.body(13, color: Brand.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileLink extends StatelessWidget {
  const _MobileLink({
    required this.index,
    required this.label,
    required this.onTap,
  });

  final String index;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                index,
                style: T.mono(10, color: Brand.cyan, letterSpacing: 1.4),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  label,
                  style: T.display(32, weight: FontWeight.w500, height: 1.05),
                ),
              ),
              const Icon(
                Icons.arrow_outward_rounded,
                size: 20,
                color: Brand.dim,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
