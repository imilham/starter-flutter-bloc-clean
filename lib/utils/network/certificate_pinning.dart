
import 'package:dio/dio.dart';
import 'package:starter/utils/network/client.dart' show ApiClient;
import 'package:starter/utils/network/network.dart' show ApiClient;
import 'package:starter/utils/utils.dart' show ApiClient;

/// Scaffold for certificate (public-key) pinning.
///
/// **How to enable:**
/// 1. Obtain your server's SHA-256 SPKI fingerprint:
///    ```bash
///    openssl s_client -connect YOUR_DOMAIN:443 | \
///      openssl x509 -pubkey -noout | \
///      openssl pkey -pubin -outform der | \
///      openssl dgst -sha256 -binary | openssl enc -base64
///    ```
/// 2. Add the base-64 hash to [_pinnedHashes] below.
/// 3. Register this interceptor in [ApiClient]:
///    ```dart
///    ApiClient(
///      interceptors: [
///        CertificatePinningInterceptor(),
///        AuthInterceptor(),
///        TokenExpirationInterceptor(),
///      ],
///    )
///    ```
///
/// **Important**: Include at least two hashes — the current certificate and
/// a backup — so a certificate rotation doesn't brick the app.
class CertificatePinningInterceptor extends Interceptor {
  CertificatePinningInterceptor({
    List<String> pinnedHashes = const [],
  }) : _pinnedHashes = pinnedHashes;

  // ignore: unused_field
  final List<String> _pinnedHashes;

  // TODO(security): Replace with your actual SHA-256 SPKI hashes.
  // Example:
  // static const _defaultHashes = [
  //   'sha256/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=', // primary
  //   'sha256/BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=', // backup
  // ];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Certificate pinning is best done at the HttpClient level.
    // For Dio, override the HttpClientAdapter:
    //
    // dio.httpClientAdapter = IOHttpClientAdapter(
    //   createHttpClient: () {
    //     final client = HttpClient();
    //     client.badCertificateCallback = (cert, host, port) {
    //       // Compare cert.pem SHA-256 against _pinnedHashes
    //       return false; // reject by default
    //     };
    //     return client;
    //   },
    // );
    //
    // See: https://pub.dev/packages/dio#httpClientAdapter

    handler.next(options);
  }
}
