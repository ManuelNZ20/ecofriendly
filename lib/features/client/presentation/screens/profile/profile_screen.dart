import 'package:ecofriendly_flutter_app/core/shared/widgets/icon_button_arrow_back.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const String name = 'profile_screen';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonArrowBack(),
        title: const Text('Ecofriendly'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "¡Bienvenido a Ecofriendly - Tu tienda en línea de confianza!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Image.asset(
                'assets/images/profile_2.png', // Asegúrate de tener esta imagen en tu carpeta de assets
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              "¿Buscas productos ecológicos y no los encuentras fácilmente? 🌿 ¡Nuestra tienda ecológica es la solución! Ofrecemos una amplia gama de productos sostenibles que cuidan del planeta y simplifican tu vida diaria. ¡Compra de forma consciente y cómoda hoy mismo! ♻️",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "Nuestra tienda ecológica te permite comprar productos sostenibles desde tu smartphone o tableta. 🌱 Ofrecemos una amplia variedad de artículos ecológicos a precios competitivos, facilitando un estilo de vida consciente y responsable. ♻️",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            const Text(
              "Características principales:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "• Nuestra tienda ecológica ofrece una amplia selección de productos sostenibles, con navegación intuitiva, descripciones detalladas, precios competitivos, pagos seguros y envíos rápidos. Además, brindamos un excelente servicio al cliente. 🌿🌱",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Beneficios para el usuario:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              "• Ahorra tiempo y dinero comprando desde la comodidad de tu hogar.\n"
              "• Compara precios y encuentra las mejores ofertas.\n"
              "• Accede a una amplia variedad de productos que no encuentras en tu ferretería local.\n"
              "• Recibe tus pedidos en la puerta de tu casa.\n"
              "• Disfruta de un servicio al cliente atento y profesional.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Cotlear es la forma más fácil y conveniente de comprar todo lo que necesitas para tus proyectos de bricolaje y reparaciones del hogar.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Información adicional:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              "• Versión actual: 1.0\n"
              "• Desarrollador: Navarro Zeta Manuel Walter\n"
              "• Sitio web: https://www.appspaginasweb.com/\n"
              "• Correo electrónico: mnavarroz@ucvvirtual.edu.pe\n",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Image.asset(
                'assets/images/profile_3.png',
                width: 250,
                height: 250,
              ),
            ),
            const SizedBox(height: 20.0),
            const Center(
              child: Text(
                "Redes Sociales",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Facebook"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Instagram'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Instagram"),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Center(
              child: Text(
                "¡Gracias por usar EcoFriendly!",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
