import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/shared/infrastructure/infrastructure.dart';
import '../../features/auth/presentation/screens/screens.dart';
import '../../features/cart/presentation/screens/screens.dart';
import '../../features/company/presentation/screens/screens.dart';
import '../../features/client/presentation/screens/screens.dart';
import '../../features/onboarding/presentation/screens.dart';
import 'app_router_notifier.dart';
import '../../features/auth/presentation/riverpod/providers.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      // Splash
      GoRoute(
        path: '/splash',
        name: CheckAuthStatusScreen.name,
        builder: (context, state) {
          return const CheckAuthStatusScreen();
        },
      ),
      // OnBoarding
      GoRoute(
        path: '/onboarding',
        name: OnboardingScreen.name,
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),
      // Auth Routes
      GoRoute(
        path: '/login',
        name: LoginScreen.name,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/business_option',
        name: BusinessOptionScreen.name,
        builder: (context, state) {
          return const BusinessOptionScreen();
        },
      ),
      GoRoute(
        path: '/register_user',
        name: RegisterUserScreen.name,
        builder: (context, state) {
          return const RegisterUserScreen();
        },
      ),
      GoRoute(
        path: '/register_company',
        name: RegisterCompanyScreen.name,
        builder: (context, state) {
          return const RegisterCompanyScreen();
        },
      ),
      GoRoute(
        path: '/verify_otp_user/:email',
        name: VerifyUserOtpScreen.name,
        builder: (context, state) {
          final email = state.pathParameters['email']!;
          return VerifyUserOtpScreen(
            email: email,
          );
        },
      ),
      GoRoute(
        path: '/verify_otp_company/:email',
        name: VerifyCompanyOtpScreen.name,
        builder: (context, state) {
          final email = state.pathParameters['email']!;
          return VerifyCompanyOtpScreen(
            email: email,
          );
        },
      ),
      // HOME - CLIENT
      GoRoute(
        path: '/home/:page',
        name: HomeClientScreen.name,
        builder: (context, state) {
          final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
          return HomeClientScreen(
            pageIndex: pageIndex,
          );
        },
        routes: [
          // PRODUCT
          GoRoute(
            path: 'product/:idProduct',
            name: ProductDetailScreen.name,
            builder: (context, state) {
              final idProduct = state.pathParameters['idProduct'];
              return ProductDetailScreen(
                productId: int.parse(idProduct!),
              );
            },
          ),
          GoRoute(
            path: 'products-all',
            builder: (context, state) {
              return const ProductsAllScreen();
            },
          ),
          // Categories
          GoRoute(
            path: 'categories',
            builder: (context, state) => const CategoriesScreen(),
            routes: [
              GoRoute(
                path: 'productscategories/:idCategory',
                builder: (context, state) {
                  final idCategory = state.pathParameters['idCategory'];
                  return ProductsByIdCategoryScreen(
                    categoryId: idCategory!,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: 'order_detail/:order_id',
            name: OrderDetailScreen.name,
            builder: (context, state) {
              final orderId = state.pathParameters['order_id'];
              return OrderDetailScreen(
                orderId: int.parse(orderId!),
              );
            },
          ),
          GoRoute(
            path: 'profile',
            name: ProfileScreen.name,
            builder: (context, state) {
              return const ProfileScreen();
            },
          ),
        ],
      ),
      // HOME - COMPANY
      GoRoute(
        path: '/home_company',
        builder: (context, state) {
          return const HomeCompanyScreen();
        },
        routes: [
          GoRoute(
            path: 'product/:id_product',
            name: ProductCompanyScreen.name,
            builder: (context, state) {
              final id = state.pathParameters['id_product'] ?? 'no-id';
              return ProductCompanyScreen(
                idProduct: int.parse(id),
              );
            },
          ),
          GoRoute(
            path: 'banner/:id_banner',
            name: BannerCompanyScreen.name,
            builder: (context, state) {
              final id = state.pathParameters['id_banner'] ?? 'no-id';
              return BannerCompanyScreen(
                idBanner: id,
              );
            },
          ),
          GoRoute(
              path: 'profile/:id_company',
              name: HomeProfileCompanyScreen.name,
              builder: (context, state) {
                final id = state.pathParameters['id_company'] ?? 'no-id';
                return HomeProfileCompanyScreen(
                  idCompany: id,
                );
              },
              routes: [
                GoRoute(
                  path: 'page_company/:id',
                  name: PageProfileCompany.name,
                  builder: (context, state) {
                    final id = state.pathParameters['id'] ?? 'no-id';
                    return PageProfileCompany(
                      idCompany: id,
                    );
                  },
                ),
              ]),
        ],
      ),
    ],
    redirect: (context, state) async {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;
      final keyValueStorageService = KeyValueStorageImpl();

      print('$isGoingTo $authStatus');
      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }
      if (authStatus == AuthStatus.noAuthenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/business_option' ||
            isGoingTo == '/register_user' ||
            isGoingTo == '/register_company' ||
            isGoingTo == '/onboarding') return null;
        final isOnBoarding = await keyValueStorageService
                .getValue<bool>('onboarding_completed') ??
            false;
        if (!isOnBoarding) {
          return '/onboarding';
        }
        return '/login';
      }
      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          final keyValueStorageService = KeyValueStorageImpl();
          final typeUser =
              await keyValueStorageService.getValue<int>('type_user');
          if (typeUser == 1) {
            return '/home/0';
          }
          return '/home_company';
        }
      }
      return null;
    },
  );
});
