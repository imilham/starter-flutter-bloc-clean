import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:starter/auth/controller/biometric_controller.dart';
import 'package:starter/more/view/samples/sample_section.dart';
import 'package:starter/utils/utils.dart';

class BiometricSample extends StatefulWidget {
  const BiometricSample({super.key});

  @override
  State<BiometricSample> createState() => _BiometricSampleState();
}

class _BiometricSampleState extends State<BiometricSample> {
  final _controller = BiometricController();
  bool? _isAvailable;
  List<BiometricType> _availableBiometrics = [];
  String _authStatus = 'Not tested';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkAvailability();
  }

  Future<void> _checkAvailability() async {
    setState(() => _isLoading = true);
    final isAvailable = await _controller.isAvailable;
    final biometrics = await _controller.getAvailableBiometrics();
    if (mounted) {
      setState(() {
        _isAvailable = isAvailable;
        _availableBiometrics = biometrics;
        _isLoading = false;
      });
    }
  }

  Future<void> _authenticate() async {
    setState(() {
      _isLoading = true;
      _authStatus = 'Authenticating...';
    });
    
    final success = await _controller.authenticate(
      localizedReason: 'Testing biometric authentication from Design System',
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
        _authStatus = success ? 'Success! Authorized.' : 'Failed / Canceled';
      });
      
      if (success) {
        context.showSuccessSnackBar('Authentication Successful');
      } else {
        context.showErrorSnackBar('Authentication Failed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Biometric Authentication',
          style: context.textTheme.headlineMedium,
        ),
        Gap.small8,
        Text(
          'Secure access using FaceID or Fingerprint.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        Gap.medium16,
        const _InfoBanner(),
        Gap.medium16,
        const Divider(),
        Gap.medium16,
        
        // Live Preview
        SampleSection(
          title: 'Live Preview',
          icon: Icons.fingerprint,
          isExpanded: true,
          children: [
             if (_isLoading)
               const Center(child: CircularProgressIndicator())
             else ...[
               _StatusRow(
                 label: 'Hardware Available:',
                 value: _isAvailable?.toString() ?? 'Checking...',
                 isSuccess: _isAvailable == true,
               ),
               Gap.small8,
               _StatusRow(
                 label: 'Enrolled Biometrics:',
                 value: _availableBiometrics.isEmpty 
                     ? 'None' 
                     : _availableBiometrics.map((e) => e.name).join(', '),
                 isSuccess: _availableBiometrics.isNotEmpty,
               ),
               Gap.large24,
               Text('Auth Status: $_authStatus', style: bodySmall14(fontWeight: FontWeight.bold)),
               Gap.small8,
               CommonElevatedButton(
                 text: 'Test Authentication',
                 onPressed: (_isAvailable == true) ? _authenticate : null,
                 icon: Icons.lock_open,
               ),
             ],
          ],
        ),

        Gap.medium16,
        Text(
          'Developer Guide',
          style: context.textTheme.titleLarge,
        ),
        Gap.medium16,

        // Guide Steps
        const SampleSection(
          title: 'Setup & Configuration',
          icon: Icons.settings_applications,
          children: [
            _StepItem(
              step: '1',
              title: 'Add Dependency',
              description: 'Add `local_auth` to your pubspec.yaml.',
            ),
            _StepItem(
              step: '2',
              title: 'Android Config',
              description: 'Update `AndroidManifest.xml` to include `USE_BIOMETRIC` permission and `MainActivity` class changes if needed (FragmentActivity).',
            ),
            _StepItem(
              step: '3',
              title: 'iOS Config',
              description: 'Add `NSFaceIDUsageDescription` key to `Info.plist`.',
            ),
          ],
        ),
        
        const SampleSection(
          title: 'Implementation',
          icon: Icons.code,
          children: [
             _StepItem(
              step: '4',
              title: 'Controller',
              description: 'Use `BiometricController` to wrap `LocalAuthentication` logic explicitly.',
            ),
             _StepItem(
              step: '5',
              title: 'Authenticate',
              description: 'Call `authenticate()` with a localized reason string.',
            ),
          ],
        ),
      ],
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.label,
    required this.value,
    this.isSuccess = false,
  });

  final String label;
  final String value;
  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: bodyRegular16()),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isSuccess ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: isSuccess ? Colors.green : Colors.red),
          ),
          child: Text(
            value,
            style: bodySmall14(
              textColor: isSuccess ? Colors.green.shade700 : Colors.red.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info, color: context.colorScheme.primary),
          Gap.medium16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Need full login integration?',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
                Gap.small8,
                Text(
                  'Check `feature/biometric-auth-im` for the complete login flow integration including secure storage of credentials.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  const _StepItem({
    required this.step,
    required this.title,
    required this.description,
  });

  final String step;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colorScheme.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: Text(
              step,
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Gap.medium16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
