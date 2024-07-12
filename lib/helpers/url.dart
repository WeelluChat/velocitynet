import 'package:url_launcher/url_launcher.dart';

class Url {
  Future<void> urlWhatsApp() async {
    await launchUrl(
      Uri.parse(
          "https://api.whatsapp.com/send?phone=+559499260-0430&text=Óla tudo bem ?"),
    );
  }

  Future<void> urlCentralAssinante() async {
    await launchUrl(
      Uri.parse(
          "https://sistema.velocitynet.com.br/central_assinante_web/login"),
    );
  }

  Future<void> urlSpeedTest() async {
    await launchUrl(
      Uri.parse("https://www.speedtest.net/pt"),
    );
  }

  Future<void> urlInstagram() async {
    await launchUrl(
      Uri.parse("https://www.instagram.com/velocitynet.oficial/"),
    );
  }

  Future<void> urlFacebook() async {
    await launchUrl(
      Uri.parse("https://www.facebook.com/velocitynettelecom"),
    );
  }

  Future<void> urlMaps() async {
    await launchUrl(
      Uri.parse("https://maps.app.goo.gl/AYWLVsUVsNWPtz2E6"),
    );
  }

  Future<void> urlGmail() async {
    await launchUrl(
      Uri.parse("mailto:velocitynetfinanceiro@gmail.com"),
    );
  }

  Future<void> urlWeellu() async {
    await launchUrl(
      Uri.parse("https://webchat.weellu.com/"),
    );
  }

  Future<void> urlPlayStore() async {
    await launchUrl(
      Uri.parse(
          "https://play.google.com/store/apps/details?id=br.tv.ole.oletv&hl=en_US"),
    );
  }

  Future<void> urlAppStore() async {
    await launchUrl(
      Uri.parse("https://apps.apple.com/br/app/ol%C3%A9-tv/id1301299065"),
    );
  }
}
