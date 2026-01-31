import 'package:flutter/material.dart';
import 'package:starter/app/app.dart';
import 'package:starter/utils/utils.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  late PageController _pageController;
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Withdrawal Restricted Savings Accounts',
      'description':
          'Create your account in the settings if you have into do so. Select the amount and deposit interval and set the date for how long you willing to save for you',
      'features': [
        {
          'title': 'Feature 1',
          'description': 'Feature 1 description',
        },
        {
          'title': 'Feature 2',
          'description': 'Feature 2 description',
        },
        {
          'title': 'Feature 3',
          'description': 'Feature 3 description',
        },
      ],
    },
    {
      'title': 'Withdrawal Restricted Savings Accounts',
      'description':
          'Create your account in the settings if you have into do so. Select the amount and deposit interval and set the date for how long you willing to save for you',
      'features': [
        {
          'title': 'Feature 1',
          'description': 'Feature 1 description',
        },
        {
          'title': 'Feature 2',
          'description': 'Feature 2 description',
        },
        {
          'title': 'Feature 3',
          'description': 'Feature 3 description',
        },
      ],
    },
    {
      'title': 'Withdrawal Restricted Savings Accounts',
      'description':
          'Create your account in the settings if you have into do so. Select the amount and deposit interval and set the date for how long you willing to save for you',
      'features': [
        {
          'title': 'Feature 1',
          'description': 'Feature 1 description',
        },
        {
          'title': 'Feature 2',
          'description': 'Feature 2 description',
        },
        {
          'title': 'Feature 3',
          'description': 'Feature 3 description',
        },
      ],
    },
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: context.theme.cardColor,
                          borderRadius: AppRadius.large16,
                          boxShadow: [
                            BoxShadow(
                              color: context.colorScheme.shadow,
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate(
                              (_pages[index]['features'] as List<dynamic>).length,
                              (index) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: context.theme.cardColor,
                                  borderRadius: AppRadius.small8,
                                  border: Border.all(
                                    color: context.colorScheme.primary,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: context.colorScheme.shadow,
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: context.theme.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Transform.rotate(
                                          angle: 0.585398,
                                          child: const Icon(
                                            Icons.notifications_active_rounded,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Gap.medium16,
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (_pages[index]['features'] as List<Map>)[index]['title'].toString(),
                                          style: context.bodyRegular16(
                                            color: context.colorScheme.secondary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Gap.extraSmall4,
                                        Text(
                                          (_pages[index]['features'] as List<Map>)[index]['description'].toString(),
                                          style: context.bodyRegular16(),
                                        ),
                                      ],
                                    ),
                                    Gap.medium16,
                                  ],
                                ),
                              ),
                            ),
                            Gap.medium12,
                            Text(
                              _pages[index]['title'].toString(),
                              style: context.headline24(
                                color: context.colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap.medium16,
                            Text(
                              _pages[index]['description'].toString(),
                              style: context.bodyRegular16(),
                            ),
                            Gap.large24,
                          ],
                        ).paddingAll24,
                      ).paddingHorizontal24,
                      Gap.medium16,
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentIndex == index ? 16 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentIndex == index ? context.theme.primaryColor : Colors.grey,
                        borderRadius: AppRadius.extraSmall4,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Gap.extraLarge32,
            Gap.medium16,
            ElevatedButton(
              onPressed: () {
                GetIt.I<AppStates>().isTutorialShown = true;
              },
              child: Text(
                _currentIndex == 2 ? 'Get Started' : 'Skip',
                style: context.bodyRegular16(fontWeight: FontWeight.bold),
              ),
            ),
            const RelativeGap(mainAxisExtent: 0.04),
          ],
        ),
      ),
    );
  }
}
