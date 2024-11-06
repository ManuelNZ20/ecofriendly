import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/shared/shared.dart';

enum BusinessOption { users, ecofrinedly }

class BusinessOptionScreen extends StatefulWidget {
  static const String name = 'business_option_screen';
  const BusinessOptionScreen({super.key});

  @override
  State<BusinessOptionScreen> createState() => _BusinessOptionScreenState();
}

class _BusinessOptionScreenState extends State<BusinessOptionScreen> {
  BusinessOption selectedBusiness = BusinessOption.users;

  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        );
    final titlePrevious = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w300,
          color: Theme.of(context).colorScheme.primary,
        );
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Spacer(flex: 1),
              Icon(
                Icons.eco_outlined,
                color: colors.primary,
                size: 70,
              ),
              const SizedBox(height: 20),
              Text(
                'Elige un Perfil Digital',
                style: title,
              ),
              const SizedBox(height: 20),
              RadioListTile(
                title: const Text('Usuario'),
                subtitle: const Text('Compras y feedback'),
                value: BusinessOption.users,
                groupValue: selectedBusiness,
                secondary: Icon(
                  Icons.person,
                  color: selectedBusiness == BusinessOption.users
                      ? colors.primary
                      : null,
                ),
                onChanged: (value) => setState(
                  () {
                    selectedBusiness = BusinessOption.users;
                  },
                ),
              ),
              RadioListTile(
                value: BusinessOption.ecofrinedly,
                title: const Text('Ecofriendly'),
                secondary: Icon(
                  Icons.business_outlined,
                  color: selectedBusiness == BusinessOption.ecofrinedly
                      ? colors.primary
                      : null,
                ),
                subtitle:
                    const Text('Crea tu propia empresa ecologíco digital'),
                groupValue: selectedBusiness,
                onChanged: (value) => setState(
                  () {
                    selectedBusiness = BusinessOption.ecofrinedly;
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: CustomFilledButton(
                  text: 'Continuar',
                  onPressed: () {
                    if (selectedBusiness == BusinessOption.ecofrinedly) {
                      context.push('/register_company');
                      return;
                    }
                    context.push('/register_user');
                  },
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  'Volver',
                  style: titlePrevious,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
