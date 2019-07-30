# @summary Logging
#
class quagga::logging (
  Variant[
    Enum['monitor', 'stdout', 'syslog'],
    Pattern[/\Afile\s(\/\S+)+\Z/]
  ]                              $backend,
  Enum[
    'alerts',
    'critical',
    'debugging',
    'emergencies',
    'errors',
    'informational',
    'notifications',
    'warnings'
  ]                              $level,
) {

  $backend_type = regsubst($backend, '\Afile\s(\/\S+)+\Z', 'file')
  $filename = regsubst($backend, '\Afile\s', '')

  quagga_logging { $backend_type:
    filename => $filename,
    level    => $level,
  }

}
