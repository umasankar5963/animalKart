import 'package:animal_kart/theme/app_theme.dart';
import 'package:animal_kart/widgets/customIcon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String _selectedRole = 'Buyer';
  bool _rememberMe = false;

  // Mock credentials for different roles
  final Map<String, Map<String, String>> _mockCredentials = {
    'buyer': {'email': 'buyer@animalkart.com', 'password': 'buyer123'},
    'supervisor': {
      'email': 'superVisor@animalkart.com',
      'password': 'superVisor123',
    },
    'doctor': {'email': 'doctor@animalkart.com', 'password': 'doctor123'},
    'transport': {
      'email': 'transport@animalkart.com',
      'password': 'transport123',
    },
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get role from route arguments if available
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['role'] != null) {
      setState(() {
        _selectedRole = args['role'];
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Color _getRoleColor() {
    switch (_selectedRole.toLowerCase()) {
      case 'buyer':
        return AppTheme.lightTheme.colorScheme.tertiary;
      case 'superVisor':
        return const Color(0xFFF57C00);
      case 'doctor':
        return const Color(0xFF7B1FA2);
      case 'transport':
        return const Color(0xFF388E3C);
      default:
        return AppTheme.lightTheme.primaryColor;
    }
  }

  String _getRoleIcon() {
    switch (_selectedRole.toLowerCase()) {
      case 'buyer':
        return 'shopping_cart';
      case 'superVisor':
        return 'store';
      case 'doctor':
        return 'medical_services';
      case 'transport':
        return 'local_shipping';
      default:
        return 'person';
    }
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Reset Password',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter your email address to receive password reset instructions.',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            SizedBox(height: 2.h),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email Address',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password reset link sent to your email'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Send Reset Link'),
          ),
        ],
      ),
    );
  }

  void _showOTPVerification() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 4.w,
          right: 4.w,
          top: 2.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'OTP Verification',
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
            SizedBox(height: 1.h),
            Text(
              'Enter the 6-digit code sent to your registered mobile number',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => Container(
                  width: 12.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: _getRoleColor()),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                    ),
                    style: AppTheme.lightTheme.textTheme.titleLarge,
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _navigateToDashboard();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getRoleColor(),
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                ),
                child: const Text('Verify OTP'),
              ),
            ),
            SizedBox(height: 1.h),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('OTP resent successfully')),
                );
              },
              child: Text(
                'Resend OTP',
                style: TextStyle(color: _getRoleColor()),
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void _navigateToDashboard() {
    HapticFeedback.lightImpact();

    switch (_selectedRole.toLowerCase()) {
      case 'buyer':
        Navigator.pushReplacementNamed(context, '/buyer-dashboard');
        break;
      case 'superVisor':
        Navigator.pushReplacementNamed(context, '/superVisor-dashboard');
        break;
      case 'doctor':
        // Navigate to doctor dashboard when available
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Doctor dashboard coming soon')),
        );
        break;
      case 'transport':
        // Navigate to transport dashboard when available
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transport dashboard coming soon')),
        );
        break;
    }
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate authentication delay
    await Future.delayed(const Duration(seconds: 1));

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final mockCreds = _mockCredentials[_selectedRole]!;

    if (email == mockCreds['email'] && password == mockCreds['password']) {
      // Show OTP verification for demo
      setState(() => _isLoading = false);
      _showOTPVerification();
    } else {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Invalid credentials. Use ${mockCreds['email']} / ${mockCreds['password']}',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h),

                  // Header Section
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          '/role-selection-screen',
                        ),
                        icon: CustomIconWidget(
                          iconName: 'arrow_back',
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: _getRoleColor().withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CustomIconWidget(
                          iconName: _getRoleIcon(),
                          color: _getRoleColor(),
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Login as $_selectedRole',
                              style: AppTheme.lightTheme.textTheme.titleLarge
                                  ?.copyWith(
                                    color: _getRoleColor(),
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            Text(
                              'Welcome back to AnimalKart',
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                    color: AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.7),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  // Login Form Section
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign In',
                          style: AppTheme.lightTheme.textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 4.h),

                        // Email/Phone Field
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email or Phone',
                            hintText: 'Enter your email or phone number',
                            prefixIcon: CustomIconWidget(
                              iconName: 'email',
                              color: _getRoleColor(),
                              size: 20,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email or phone';
                            }
                            if (!value.contains('@') && value.length < 10) {
                              return 'Please enter a valid email or phone number';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 3.h),

                        // Password Field
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            prefixIcon: CustomIconWidget(
                              iconName: 'lock',
                              color: _getRoleColor(),
                              size: 20,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: CustomIconWidget(
                                iconName: _isPasswordVisible
                                    ? 'visibility_off'
                                    : 'visibility',
                                color: Colors.grey[600]!,
                                size: 20,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 2.h),

                        // Remember Me & Forgot Password
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                              activeColor: _getRoleColor(),
                            ),
                            Text(
                              'Remember me',
                              style: AppTheme.lightTheme.textTheme.bodyMedium,
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: _showForgotPasswordDialog,
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: _getRoleColor(),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.spa,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 3.h),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _getRoleColor(),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Login',
                                    style: AppTheme
                                        .lightTheme
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 4.h),

                  // // Biometric Authentication Section
                  // Container(
                  //   width: double.infinity,
                  //   padding: EdgeInsets.all(4.w),
                  //   decoration: BoxDecoration(
                  //     color: AppTheme.lightTheme.cardColor,
                  //     borderRadius: BorderRadius.circular(12),
                  //     border: Border.all(
                  //       color: _getRoleColor().withValues(alpha: 0.2),
                  //     ),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       CustomIconWidget(
                  //         iconName: 'fingerprint',
                  //         color: _getRoleColor(),
                  //         size: 32,
                  //       ),
                  //       SizedBox(height: 1.h),
                  //       Text(
                  //         'Use Biometric Login',
                  //         style: AppTheme.lightTheme.textTheme.titleSmall
                  //             ?.copyWith(
                  //               color: _getRoleColor(),
                  //               fontWeight: FontWeight.w600,
                  //             ),
                  //       ),
                  //       SizedBox(height: 0.5.h),
                  //       Text(
                  //         'Touch sensor or use Face ID',
                  //         style: AppTheme.lightTheme.textTheme.bodySmall
                  //             ?.copyWith(color: Colors.grey[600]),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 4.h),

                  // Switch Role Section
                  Center(
                    child: TextButton.icon(
                      onPressed: () => Navigator.pushReplacementNamed(
                        context,
                        '/role-selection-screen',
                      ),
                      icon: CustomIconWidget(
                        iconName: 'swap_horiz',
                        color: _getRoleColor(),
                        size: 20,
                      ),
                      label: Text(
                        'Switch Role',
                        style: TextStyle(
                          color: _getRoleColor(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // Demo Credentials Info
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blue.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'info',
                              color: Colors.blue,
                              size: 20,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              'Demo Credentials',
                              style: AppTheme.lightTheme.textTheme.titleSmall
                                  ?.copyWith(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Email: ${_mockCredentials[_selectedRole]!['email']}\nPassword: ${_mockCredentials[_selectedRole]!['password']}',
                          style: AppTheme.lightTheme.textTheme.bodySmall
                              ?.copyWith(
                                color: Colors.blue[700],
                                fontFamily: 'monospace',
                              ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
