/**
 * Copyright 2020-2021 by Vegard IT GmbH (https://vegardit.com) and contributors.
 * SPDX-License-Identifier: Apache-2.0
 *
 * @author Sebastian Thomschke, Vegard IT GmbH
 */
import 'dart:developer' as dev;

import 'package:vm_service/utils.dart' as vms_utils;
import 'package:vm_service/vm_service.dart' as vms;
import 'package:vm_service/vm_service_io.dart' as vms_io;

/**
 * @throws StateError if VM service is not available
 */
Future<vms.VmService> _getVmService() async {
  final devServiceURL = (await dev.Service.getInfo()).serverUri;
  if (devServiceURL == null) {
    throw new StateError('VM service not available! You need to run dart with --enable-vm-service.');
  }
  final wsURL = vms_utils.convertToWebSocketUrl(serviceProtocolUrl: devServiceURL);
  return await vms_io.vmServiceConnectUri(wsURL.toString());
}

late final Future<vms.VmService> vmService = _getVmService();
