import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

MobileScannerController useMobileScannerController({
  List<Object?>? keys,
  List<BarcodeFormat>? formats,
}) {
  return use(
    _MobileScannerControllerHook(
      keys: keys,
      formats: formats,
    ),
  );
}

class _MobileScannerControllerHook extends Hook<MobileScannerController> {
  final List<BarcodeFormat>? formats;

  const _MobileScannerControllerHook({
    super.keys,
    this.formats,
  });

  @override
  HookState<MobileScannerController, Hook<MobileScannerController>>
      createState() => _MobileScannerControllerHookState();
}

class _MobileScannerControllerHookState
    extends HookState<MobileScannerController, _MobileScannerControllerHook> {
  late final controller = MobileScannerController(
    formats: hook.formats ?? const [BarcodeFormat.qrCode],
    autoStart: true,
    detectionTimeoutMs: 1000,
  );

  @override
  MobileScannerController build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'useMobileScannerController';
}
