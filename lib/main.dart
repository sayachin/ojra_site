import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

import 'content.dart';
import 'sections/contact_section.dart';
import 'sections/hero_section.dart';
import 'sections/process_section.dart';
import 'sections/product_section.dart';
import 'sections/services_section.dart';
import 'sections/studio_section.dart';
import 'theme.dart';
import 'widgets/common.dart';
import 'widgets/footer.dart';
import 'widgets/nav_bar.dart';

void main() {
  runApp(const NewAgeFactoriesApp());
}

class NewAgeFactoriesApp extends StatelessWidget {
  const NewAgeFactoriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Age Factories — Digital Product Studio',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      scrollBehavior: const _SiteScrollBehavior(),
      home: const SitePage(),
    );
  }
}

class _SiteScrollBehavior extends MaterialScrollBehavior {
  const _SiteScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => const {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

class SitePage extends StatefulWidget {
  const SitePage({super.key});

  @override
  State<SitePage> createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  final _scroll = ScrollController();
  final Map<String, GlobalKey> _sections = {
    'services': GlobalKey(),
    'ojra': GlobalKey(),
    'process': GlobalKey(),
    'studio': GlobalKey(),
    'contact': GlobalKey(),
  };

  static const _navOffset = 82.0;

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _navigate(String id) {
    if (id == 'home') {
      _scrollTop();
      return;
    }
    final key = _sections[id];
    final context = key?.currentContext;
    if (context == null) return;
    final box = context.findRenderObject();
    if (box is! RenderBox) return;
    final viewport = RenderAbstractViewport.of(box);
    final target = viewport.getOffsetToReveal(box, 0).offset - _navOffset + 10;
    final max = _scroll.position.maxScrollExtent;
    _scroll.animateTo(
      target.clamp(0.0, max),
      duration: const Duration(milliseconds: 850),
      curve: Curves.easeInOutCubic,
    );
  }

  void _scrollTop() {
    if (!_scroll.hasClients) return;
    _scroll.animateTo(
      0,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Brand.bg,
      body: Stack(
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              child: CustomPaint(painter: const BackdropPainter()),
            ),
          ),
          Positioned.fill(
            child: Scrollbar(
              controller: _scroll,
              child: SingleChildScrollView(
                controller: _scroll,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HeroSection(
                      onExploreWork: () => _navigate('services'),
                      onStartProject: () => _navigate('contact'),
                      onOpenProduct: () => _navigate('ojra'),
                    ),
                    KeyedSubtree(
                      key: _sections['services'],
                      child: ServicesSection(
                        onStartProject: () => _navigate('contact'),
                      ),
                    ),
                    KeyedSubtree(
                      key: _sections['ojra'],
                      child: ProductSection(
                        onStartProject: () => _navigate('contact'),
                        onExploreProcess: () => _navigate('process'),
                      ),
                    ),
                    KeyedSubtree(
                      key: _sections['process'],
                      child: const ProcessSection(),
                    ),
                    KeyedSubtree(
                      key: _sections['studio'],
                      child: StudioSection(
                        onStartProject: () => _navigate('contact'),
                      ),
                    ),
                    KeyedSubtree(
                      key: _sections['contact'],
                      child: const ContactSection(),
                    ),
                    SiteFooter(
                      onNavigate: _navigate,
                      onEmail: _openEmail,
                      onTop: _scrollTop,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SiteNav(
              scrollController: _scroll,
              onNavigate: _navigate,
              onStartProject: () => _navigate('contact'),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(child: _ScrollProgress(controller: _scroll)),
          ),
        ],
      ),
    );
  }

  Future<void> _openEmail() async {
    try {
      final launched = await launchUrl(
        Uri.parse(kEmailUri),
        mode: LaunchMode.externalApplication,
      );
      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Email us at $kContactEmail',
              style: T.body(13, color: Brand.ink),
            ),
            backgroundColor: Brand.surfaceRaised,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Email us at $kContactEmail',
            style: T.body(13, color: Brand.ink),
          ),
          backgroundColor: Brand.surfaceRaised,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

class _ScrollProgress extends StatelessWidget {
  const _ScrollProgress({required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        double progress = 0;
        if (controller.hasClients) {
          final position = controller.position;
          if (position.hasPixels &&
              position.hasContentDimensions &&
              position.hasViewportDimension &&
              position.maxScrollExtent > 0) {
            progress = (position.pixels / position.maxScrollExtent).clamp(
              0.0,
              1.0,
            );
          }
        }
        return Align(
          alignment: Alignment.topLeft,
          child: FractionallySizedBox(
            widthFactor: progress == 0 ? 0.0001 : progress,
            child: Container(
              height: 2,
              decoration: const BoxDecoration(gradient: Brand.signature),
            ),
          ),
        );
      },
    );
  }
}
