import 'package:animal_kart/theme/app_theme.dart';
import 'package:animal_kart/widgets/customIcon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _taglineController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _taglineFadeAnimation;
  late Animation<Offset> _taglineSlideAnimation;

  bool _isInitializing = true;
  String _initializationStatus = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    // Logo animations
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    // Tagline animations
    _taglineController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _taglineFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _taglineController, curve: Curves.easeIn),
    );

    _taglineSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _taglineController,
            curve: Curves.easeOutCubic,
          ),
        );

    // Start animations
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        _taglineController.forward();
      }
    });
  }

  Future<void> _initializeApp() async {
    try {
      // Simulate initialization tasks
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        setState(() {
          _initializationStatus = 'Loading user preferences...';
        });
      }

      await Future.delayed(const Duration(milliseconds: 800));

      if (mounted) {
        setState(() {
          _initializationStatus = 'Fetching livestock data...';
        });
      }

      await Future.delayed(const Duration(milliseconds: 700));

      if (mounted) {
        setState(() {
          _initializationStatus = 'Preparing dashboard...';
        });
      }

      await Future.delayed(const Duration(milliseconds: 500));

      // Check authentication status and navigate
      await _checkAuthenticationAndNavigate();
    } catch (e) {
      // Handle initialization errors
      if (mounted) {
        setState(() {
          _initializationStatus = 'Initialization failed. Retrying...';
        });
      }

      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        _initializeApp();
      }
    }
  }

  Future<void> _checkAuthenticationAndNavigate() async {
    if (!mounted) return;

    setState(() {
      _isInitializing = false;
    });

    // Simulate authentication check
    await Future.delayed(const Duration(milliseconds: 300));

    if (mounted) {
      // For demo purposes, navigate to role selection
      // In real app, check JWT token and user role preferences
      Navigator.pushReplacementNamed(context, '/role-selection-screen');
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _taglineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.lightTheme.colorScheme.primary,
                  AppTheme.lightTheme.colorScheme.primaryContainer,
                  AppTheme.lightTheme.colorScheme.primary.withValues(
                    alpha: 0.8,
                  ),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Section
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animated Logo
                        AnimatedBuilder(
                          animation: _logoController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _logoScaleAnimation.value,
                              child: Opacity(
                                opacity: _logoFadeAnimation.value,
                                child: Container(
                                  width: 25.w,
                                  height: 25.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4.w),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.2,
                                        ),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomIconWidget(
                                        iconName: 'pets',
                                        color: AppTheme
                                            .lightTheme
                                            .colorScheme
                                            .primary,
                                        size: 8.w,
                                      ),
                                      SizedBox(height: 1.h),
                                      Text(
                                        'AnimalKart',
                                        style: AppTheme
                                            .lightTheme
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: AppTheme
                                                  .lightTheme
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 4.h),

                        // Animated Tagline
                        AnimatedBuilder(
                          animation: _taglineController,
                          builder: (context, child) {
                            return SlideTransition(
                              position: _taglineSlideAnimation,
                              child: FadeTransition(
                                opacity: _taglineFadeAnimation,
                                child: Text(
                                  'Smart Livestock Management',
                                  style: AppTheme
                                      .lightTheme
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                        letterSpacing: 0.5,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Loading Section
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Loading Indicator
                      SizedBox(
                        width: 8.w,
                        height: 8.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ),

                      SizedBox(height: 3.h),

                      // Status Text
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          _initializationStatus,
                          key: ValueKey(_initializationStatus),
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 12.sp,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                // Version Info
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Text(
                    'Version 1.0.0',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 10.sp,
                    ),
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
