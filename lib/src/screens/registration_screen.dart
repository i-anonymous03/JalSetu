import 'package:flutter/material.dart';
import 'package:jalsetu/generated/app_localizations.dart';
import 'package:jalsetu/src/widgets/language_selector.dart';
import 'package:jalsetu/src/providers/auth_provider.dart';
import 'package:jalsetu/src/widgets/loading_overlay.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  final String role;

  const RegistrationScreen({super.key, required this.role});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  bool _isPasswordVisible = false;
  bool _otpSent = false;
  final _otpController = TextEditingController();

  // Common Fields
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Role-specific Fields
  final _genderController = TextEditingController();
  final _ageController = TextEditingController();
  final _villageController = TextEditingController();
  final _govtIdController = TextEditingController();
  final _areaController = TextEditingController();
  final _clinicNameController = TextEditingController();
  final _roleController = TextEditingController();
  final _availabilityController = TextEditingController();

  @override
  void dispose() {
  _nameController.dispose();
  _phoneController.dispose();
  _emailController.dispose();
  _passwordController.dispose();
  _genderController.dispose();
  _ageController.dispose();
  _villageController.dispose();
  _govtIdController.dispose();
  _areaController.dispose();
  _clinicNameController.dispose();
  _roleController.dispose();
  _availabilityController.dispose();
  _otpController.dispose();
  _scrollController.dispose();
  super.dispose();
  }

  Future<void> _handleRegister() async {
    final l10n = AppLocalizations.of(context)!;
    
    if (_formKey.currentState!.validate()) {
      try {
        // Prepare user data based on role
        final Map<String, dynamic> userData = {
          'name': _nameController.text,
          'phone': _phoneController.text,
          'role': widget.role,
        };

        // Add role-specific data
        switch (widget.role) {
          case 'community':
            userData.addAll({
              'gender': _genderController.text,
              'age': int.tryParse(_ageController.text) ?? 0,
              'village': _villageController.text,
            });
            break;
          case 'volunteer':
            userData.addAll({
              'govtId': _govtIdController.text,
              'area': _areaController.text,
              'availability': _availabilityController.text,
            });
            break;
          case 'doctor':
            userData.addAll({
              'clinicName': _clinicNameController.text,
              'medicalRole': _roleController.text,
              'district': _areaController.text,
            });
            break;
        }

        final authProvider = Provider.of<AuthProvider>(context, listen: false);

        // Register the user
        await authProvider.register(
          _emailController.text,
          _passwordController.text,
          widget.role,
          userData,
        );

        if (!mounted) return;

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.registrationSuccessful),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to appropriate dashboard based on role
        Navigator.pushReplacementNamed(
          context,
          authProvider.getHomeRoute(),
        );
      } catch (e) {
        // Show error message
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildRoleSpecificFields() {
    switch (widget.role) {
      case 'community':
        return Column(
          children: [
            // Gender Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
              items: ['Male', 'Female', 'Other']
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              onChanged: (value) => _genderController.text = value ?? '',
              validator: (value) =>
                  value == null ? 'Please select your gender' : null,
            ),
            const SizedBox(height: 16),

            // Age Field
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Village Field
            TextFormField(
              controller: _villageController,
              decoration: const InputDecoration(
                labelText: 'Village / Ward',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your village/ward';
                }
                return null;
              },
            ),
          ],
        );

      case 'volunteer':
        return Column(
          children: [
            // Government/NGO ID Field
            TextFormField(
              controller: _govtIdController,
              decoration: const InputDecoration(
                labelText: 'Government/NGO ID (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Assigned Area Field
            TextFormField(
              controller: _areaController,
              decoration: const InputDecoration(
                labelText: 'Assigned Area / Ward',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your assigned area';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Availability Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Availability / Shift',
                border: OutlineInputBorder(),
              ),
              items: ['Morning', 'Evening', 'Full Day']
                  .map((shift) => DropdownMenuItem(
                        value: shift,
                        child: Text(shift),
                      ))
                  .toList(),
              onChanged: (value) => _availabilityController.text = value ?? '',
              validator: (value) =>
                  value == null ? 'Please select your shift' : null,
            ),
          ],
        );

      case 'doctor':
        return Column(
          children: [
            // Clinic Name Field
            TextFormField(
              controller: _clinicNameController,
              decoration: const InputDecoration(
                labelText: 'Clinic Name / Hospital Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter clinic/hospital name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Role Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Role',
                border: OutlineInputBorder(),
              ),
              items: ['Doctor', 'Health Officer']
                  .map((role) => DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      ))
                  .toList(),
              onChanged: (value) => _roleController.text = value ?? '',
              validator: (value) =>
                  value == null ? 'Please select your role' : null,
            ),
            const SizedBox(height: 16),

            // District Field
            TextFormField(
              controller: _areaController,
              decoration: const InputDecoration(
                labelText: 'District / Area',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your district/area';
                }
                return null;
              },
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authProvider = Provider.of<AuthProvider>(context);

    return LoadingOverlay(
      isLoading: authProvider.isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(l10n.registerTitle, style: const TextStyle(color: Colors.white)),
          actions: const [
            LanguageSelector(),
            SizedBox(width: 8),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.createAccountTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.joinCommunityInstruction,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),

                // Common Fields
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: l10n.roleVillager, // Localized label
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.emailRequired; // Reuse localization
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Role-specific Fields
                _buildRoleSpecificFields(),
                const SizedBox(height: 16),

                // Contact Information
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: l10n.enterPhone,
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.emailRequired;
                          }
                          if (value.length != 10 || int.tryParse(value) == null) {
                            return l10n.emailInvalid;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _otpSent = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.sendCode)),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                      child: Text(l10n.sendCode),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                if (_otpSent) ...[
                  TextFormField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: l10n.enterOtp,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement OTP verification logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.verifyOtp)),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Text(l10n.verifyOtp),
                  ),
                  const SizedBox(height: 16),
                ],

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: l10n.emailPlaceholder,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.emailRequired;
                    }
                    if (!_isValidEmail(value)) {
                      return l10n.emailInvalid;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: l10n.passwordPlaceholder,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.passwordRequired;
                    }
                    if (value.length < 6) {
                      return l10n.featureComingSoon; // Use as placeholder
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Register Button
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(l10n.registerTitle),
                  ),
                ),
                const SizedBox(height: 16),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.dontHaveAccount),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/login',
                          arguments: widget.role,
                        );
                      },
                      child: Text(l10n.signInButton),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}