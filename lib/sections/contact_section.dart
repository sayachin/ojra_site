import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../content.dart';
import '../theme.dart';
import '../widgets/common.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _brief = TextEditingController();
  final Set<String> _services = {};
  bool _submitting = false;

  static const _choices = [
    'Mobile app',
    'Website',
    'E-commerce',
    'Digital solution',
    'Networking',
  ];

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _brief.dispose();
    super.dispose();
  }

  void _notify(String message) {
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message, style: T.body(13, color: Brand.ink)),
        backgroundColor: Brand.surfaceRaised,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Brand.lineStrong),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  Future<void> _openEmail() async {
    try {
      final launched = await launchUrl(
        Uri.parse(kEmailUri),
        mode: LaunchMode.externalApplication,
      );
      if (!launched) _notify('Email us directly at $kContactEmail');
    } catch (_) {
      _notify('Email us directly at $kContactEmail');
    }
  }

  Future<void> _copyEmail() async {
    await Clipboard.setData(const ClipboardData(text: kContactEmail));
    _notify('$kContactEmail copied to clipboard.');
  }

  Future<void> _draftEmail() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _submitting = true);

    final name = _name.text.trim();
    final email = _email.text.trim();
    final brief = _brief.text.trim();
    final services = _services.isEmpty
        ? 'a new digital project'
        : _services.map((e) => e.toLowerCase()).join(', ');
    final subject =
        'Project inquiry — ${_services.isEmpty ? 'Digital product' : _services.join(', ')}';
    final body =
        '''Hi New Age Factories team,

I'm $name. I'd like to talk about $services.

${brief.isEmpty ? 'Here is a little context about what we have in mind:' : brief}

You can reach me at $email.

— $name''';
    final uri = Uri.parse(
      'mailto:$kContactEmail?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!mounted) return;
      if (launched) {
        _notify('Your email draft is ready — send it when you are.');
      } else {
        _notify('Could not open your mail app. Write to $kContactEmail');
      }
    } catch (_) {
      _notify('Could not open your mail app. Write to $kContactEmail');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SiteBody(
      padding: const EdgeInsets.only(top: 20, bottom: 96),
      child: Reveal(
        duration: const Duration(milliseconds: 800),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Brand.line),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 80,
                spreadRadius: -20,
                offset: const Offset(0, 30),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/contact_city.jpg',
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                    semanticLabel: 'City skyline at twilight',
                  ),
                ),
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xF705070E),
                          Color(0xED060912),
                          Color(0xD905070E),
                        ],
                        stops: [0, 0.5, 1],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: const Alignment(0.85, -0.4),
                        radius: 0.9,
                        colors: [
                          Brand.cyan.withValues(alpha: 0.08),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -20,
                  bottom: -54,
                  child: IgnorePointer(
                    child: Text(
                      'NAF',
                      style: T.display(
                        250,
                        weight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: 0.022),
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.sizeOf(context).width < 720 ? 22 : 48,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final desktop = constraints.maxWidth >= 860;
                      final copy = _ContactCopy(
                        onOpenEmail: _openEmail,
                        onCopyEmail: _copyEmail,
                        compact: !desktop,
                      );
                      final form = _ContactForm(
                        formKey: _formKey,
                        name: _name,
                        email: _email,
                        brief: _brief,
                        services: _services,
                        choices: _choices,
                        submitting: _submitting,
                        onToggleService: (service) {
                          setState(() {
                            if (!_services.add(service)) {
                              _services.remove(service);
                            }
                          });
                        },
                        onSubmit: _draftEmail,
                      );
                      if (desktop) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 5, child: copy),
                            const SizedBox(width: 56),
                            Expanded(flex: 5, child: form),
                          ],
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [copy, const SizedBox(height: 36), form],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactCopy extends StatelessWidget {
  const _ContactCopy({
    required this.onOpenEmail,
    required this.onCopyEmail,
    required this.compact,
  });

  final VoidCallback onOpenEmail;
  final VoidCallback onCopyEmail;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = compact ? (width < 420 ? 39.0 : 44.0) : 54.0;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionEyebrow('05', 'Start a project'),
          const SizedBox(height: 30),
          Text("Let's build", style: T.display(titleSize, height: 1.03)),
          GradientText(
            'what comes next.',
            style: T.display(titleSize, height: 1.03),
          ),
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Text(
              'Tell us what you’re building. We’ll help shape the scope, the product and the path to launch.',
              style: T.body(15, color: Brand.muted, height: 1.7),
            ),
          ),
          SizedBox(height: compact ? 30 : 46),
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Brand.lime,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Brand.lime.withValues(alpha: 0.6),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'OPEN FOR NEW PROJECTS',
                style: T.mono(8, color: Brand.lime, letterSpacing: 1.5),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Brand.line),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PREFER EMAIL?',
                  style: T.mono(8, color: Brand.dim, letterSpacing: 1.5),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Semantics(
                        link: true,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: onOpenEmail,
                            child: Text(
                              kContactEmail,
                              style: T.display(
                                width < 430 ? 13.5 : (compact ? 17 : 19),
                                weight: FontWeight.w500,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _IconAction(
                      icon: Icons.copy_rounded,
                      tooltip: 'Copy email address',
                      onTap: onCopyEmail,
                    ),
                    const SizedBox(width: 6),
                    _IconAction(
                      icon: Icons.north_east_rounded,
                      tooltip: 'Open email app',
                      onTap: onOpenEmail,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'MOBILE APPS  /  WEBSITES  /  E-COMMERCE  /  NETWORKS',
            style: T.mono(
              7.8,
              color: Brand.dim,
              letterSpacing: 1.25,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  const _IconAction({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: tooltip,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          hoverColor: Brand.cyan.withValues(alpha: 0.08),
          splashColor: Colors.transparent,
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Brand.lineStrong),
              color: Colors.white.withValues(alpha: 0.02),
            ),
            child: Icon(icon, size: 14, color: Brand.cyan),
          ),
        ),
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  const _ContactForm({
    required this.formKey,
    required this.name,
    required this.email,
    required this.brief,
    required this.services,
    required this.choices,
    required this.submitting,
    required this.onToggleService,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController brief;
  final Set<String> services;
  final List<String> choices;
  final bool submitting;
  final ValueChanged<String> onToggleService;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xE60A0E17),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withValues(alpha: 0.11)),
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'PROJECT BRIEF',
                      style: T.mono(8.5, color: Brand.cyan, letterSpacing: 1.6),
                    ),
                    const Spacer(),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Brand.lime,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'READY',
                      style: T.mono(7.5, color: Brand.dim, letterSpacing: 1.2),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Start with the essentials.',
                  style: T.display(22, weight: FontWeight.w600, height: 1.1),
                ),
                const SizedBox(height: 6),
                Text(
                  'We read every brief ourselves.',
                  style: T.body(11.5, color: Brand.muted, height: 1.4),
                ),
                const SizedBox(height: 22),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final sideBySide = constraints.maxWidth >= 390;
                    if (sideBySide) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _FormField(
                              label: 'YOUR NAME',
                              controller: name,
                              hint: 'Name',
                              autofillHints: const [AutofillHints.name],
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please add your name.';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _FormField(
                              label: 'EMAIL',
                              controller: email,
                              hint: 'you@company.com',
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                final v = value?.trim() ?? '';
                                if (!RegExp(
                                  r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                ).hasMatch(v)) {
                                  return 'Add a valid email.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        _FormField(
                          label: 'YOUR NAME',
                          controller: name,
                          hint: 'Name',
                          autofillHints: const [AutofillHints.name],
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please add your name.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        _FormField(
                          label: 'EMAIL',
                          controller: email,
                          hint: 'you@company.com',
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            final v = value?.trim() ?? '';
                            if (!RegExp(
                              r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                            ).hasMatch(v)) {
                              return 'Add a valid email.';
                            }
                            return null;
                          },
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 18),
                Text(
                  'WHAT DO YOU NEED?',
                  style: T.mono(7.8, color: Brand.dim, letterSpacing: 1.5),
                ),
                const SizedBox(height: 9),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final choice in choices)
                      _ServiceChoice(
                        label: choice,
                        selected: services.contains(choice),
                        onTap: () => onToggleService(choice),
                      ),
                  ],
                ),
                const SizedBox(height: 18),
                _FormField(
                  label: 'A LITTLE CONTEXT',
                  controller: brief,
                  hint: 'What are you building? Anything we should know?',
                  maxLines: 3,
                  minLines: 2,
                  textInputAction: TextInputAction.newline,
                ),
                const SizedBox(height: 20),
                _SendButton(submitting: submitting, onTap: onSubmit),
                const SizedBox(height: 10),
                Text(
                  'This opens your email app with the brief filled in. Nothing is sent from this page.',
                  style: T.body(9.5, color: Brand.dim, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.label,
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.autofillHints,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final int maxLines;
  final int? minLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: T.mono(7.8, color: Brand.dim, letterSpacing: 1.5)),
        const SizedBox(height: 7),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          autofillHints: autofillHints,
          textInputAction: textInputAction,
          maxLines: maxLines,
          minLines: minLines,
          validator: validator,
          style: T.body(13, color: Brand.ink, height: 1.4),
          cursorColor: Brand.cyan,
          cursorWidth: 1.2,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: T.body(12, color: Brand.dim, height: 1.4),
            filled: true,
            fillColor: Colors.black.withValues(alpha: 0.25),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.09),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Brand.cyan.withValues(alpha: 0.55)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Brand.magenta.withValues(alpha: 0.55),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Brand.magenta.withValues(alpha: 0.75),
              ),
            ),
            errorStyle: T.mono(7.5, color: Brand.magenta, letterSpacing: 0.4),
          ),
        ),
      ],
    );
  }
}

class _ServiceChoice extends StatelessWidget {
  const _ServiceChoice({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        hoverColor: Brand.cyan.withValues(alpha: 0.05),
        splashColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: selected
                ? Brand.cyan.withValues(alpha: 0.1)
                : Colors.white.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: selected ? Brand.cyan.withValues(alpha: 0.4) : Brand.line,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected) ...[
                const Icon(Icons.check_rounded, size: 10, color: Brand.cyan),
                const SizedBox(width: 4),
              ],
              Text(
                label,
                style: T.mono(
                  8,
                  color: selected ? Brand.cyan : Brand.muted,
                  letterSpacing: 0.7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SendButton extends StatefulWidget {
  const _SendButton({required this.submitting, required this.onTap});

  final bool submitting;
  final VoidCallback onTap;

  @override
  State<_SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<_SendButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Draft the project email',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.submitting ? null : widget.onTap,
          onHover: (v) => setState(() => _hovered = v),
          borderRadius: BorderRadius.circular(9),
          hoverColor: Colors.transparent,
          splashColor: Colors.black.withValues(alpha: 0.08),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: _hovered
                  ? const LinearGradient(
                      colors: [Color(0xFF78F1FF), Brand.cyan, Brand.violet],
                    )
                  : Brand.signature,
              borderRadius: BorderRadius.circular(9),
              boxShadow: [
                BoxShadow(
                  color: Brand.cyan.withValues(alpha: _hovered ? 0.25 : 0.1),
                  blurRadius: _hovered ? 28 : 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.submitting)
                  const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: Color(0xFF031018),
                    ),
                  )
                else
                  const Icon(
                    Icons.outgoing_mail,
                    size: 16,
                    color: Color(0xFF031018),
                  ),
                const SizedBox(width: 9),
                Text(
                  widget.submitting ? 'Opening email…' : 'Draft the email',
                  style: T.body(
                    13.5,
                    weight: FontWeight.w700,
                    color: const Color(0xFF031018),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
