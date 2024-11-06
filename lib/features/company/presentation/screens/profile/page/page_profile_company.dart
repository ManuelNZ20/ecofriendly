import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../core/shared/shared.dart';
import '../../../../../../core/utils/functions/launch_url.dart';
import '../../../providers/company_app_provider.riverpod.dart';
import '../../../widgets/widgets.dart';

class PageProfileCompany extends ConsumerWidget {
  static const String name = 'page_profile_company';
  const PageProfileCompany({
    super.key,
    required this.idCompany,
  });

  final String idCompany;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final companyRes = ref.watch(companyProvider(idCompany));
    final textMessage = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Colors.grey.shade600,
        );
    final textInfo = Theme.of(context).textTheme.bodyLarge!.copyWith();
    final textTitle = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: colors.primary,
        );
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonArrowBack(),
        title: const Text('Ecofriendly'),
      ),
      body: companyRes.isLoading
          ? const FullScreenLoader()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Perfil ecofriendly',
                    style: textMessage,
                  ),
                  Text(
                    companyRes.company!.nameCompany,
                    style: textTitle,
                  ),
                  const SizedBox(height: 10),
                  _PresentationCompany(
                    imgBanner: companyRes.company!.bannerCompany!,
                    imgPresentation: companyRes.company!.imgPresentation!,
                  ),
                  const SizedBox(height: 10),
                  const TitleIconProfile(text: 'Acerca de nosotros'),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: size.width * .9,
                    height: 120,
                    child: ListView(
                      children: [
                        Text(
                          companyRes.company!.description!,
                          softWrap: true,
                          style: textInfo,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'R.U.C',
                    style: textTitle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    companyRes.company!.ruc!,
                    style: textInfo,
                  ),
                  const SizedBox(height: 12),
                  const TitleIconProfile(
                    text: 'Ubicación',
                    iconData: FontAwesomeIcons.mapLocationDot,
                  ),
                  const SizedBox(height: 12),
                  Text(companyRes.company!.address!),
                  const SizedBox(height: 10),
                  Text(companyRes.company!.location!),
                  const SizedBox(height: 10),
                  const TitleIconProfile(
                    text: 'Redes',
                    iconData: FontAwesomeIcons.globe,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton.outlined(
                        color: colors.primary,
                        onPressed: () {
                          launchUrlOpenApp(
                            Uri.parse('mailto:${companyRes.company!.email}'),
                            false,
                          );
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.envelope,
                        ),
                      ),
                      IconButton.outlined(
                        color: colors.primary,
                        onPressed: () {
                          launchUrlOpenApp(
                            Uri.parse('tel:+51${companyRes.company!.phone}'),
                            false,
                          );
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.phone,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

class _PresentationCompany extends StatelessWidget {
  const _PresentationCompany({
    required this.imgBanner,
    required this.imgPresentation,
  });

  final String imgBanner;
  final String imgPresentation;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double radius = 40;

    return SizedBox(
      width: size.width,
      height: 140,
      child: imgBanner.isEmpty
          ? Container(
              color: Colors.grey.shade300,
              child: const Text('Not banner'),
            )
          : Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Image.network(
                    imgBanner,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 8,
                    bottom: 8,
                    child: imgPresentation.isNotEmpty
                        ? CircleAvatar(
                            radius: radius,
                            backgroundImage: NetworkImage(
                              imgPresentation,
                            ),
                          )
                        : const CircleAvatar(
                            radius: radius,
                            backgroundImage:
                                AssetImage('assets/images/image-not-found.png'),
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
