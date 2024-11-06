import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/shared/shared.dart';
import '../../data/list_slides.dart';
import '../widgets/slide_app.dart';

class OnboardingScreen extends StatefulWidget {
  static const String name = 'on_boarding_screen';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  void completedOnboarding(BuildContext context) async {
    final storage = KeyValueStorageImpl();
    await storage.setKeyValue<bool>('onboarding_completed', true);
  }

  final PageController pageController = PageController();
  bool endReached = false;
  @override
  void initState() {
    super.initState();
    pageController.addListener(
      () {
        final page = pageController.page ?? 0;
        if (!endReached && page >= (slides.length - 1.5)) {
          setState(() {
            endReached = true;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            physics: const BouncingScrollPhysics(),
            children: slides
                .map(
                  (e) => SlideApp(
                    title: e.title,
                    caption: e.caption,
                    imgUrl: e.imgUrl,
                  ),
                )
                .toList(),
          ),
          Positioned(
            right: 20,
            top: 50,
            child: TextButton(
              onPressed: () {
                completedOnboarding(context);
                context.go('/splash');
              },
              child: const Text('Omitir'),
            ),
          ),
          endReached
              ? Positioned(
                  right: 20,
                  bottom: 30,
                  child: FadeInRight(
                    from: 15,
                    delay: const Duration(seconds: 1),
                    child: FilledButton(
                      onPressed: () {
                        completedOnboarding(context);
                        context.go('/splash');
                      },
                      child: const Text('Empezar'),
                    ),
                  ))
              : const SizedBox()
        ],
      ),
    );
  }
}
