//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <objectbox_flutter_libs/objectbox_flutter_libs_plugin.h>
#include <tflite_flutter/tflite_flutter_plugin.h>
#include <tflite_flutter_helper/tflite_flutter_helper_plugin.h>
#include <url_launcher_linux/url_launcher_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) objectbox_flutter_libs_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ObjectboxFlutterLibsPlugin");
  objectbox_flutter_libs_plugin_register_with_registrar(objectbox_flutter_libs_registrar);
  g_autoptr(FlPluginRegistrar) tflite_flutter_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "TfliteFlutterPlugin");
  tflite_flutter_plugin_register_with_registrar(tflite_flutter_registrar);
  g_autoptr(FlPluginRegistrar) tflite_flutter_helper_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "TfliteFlutterHelperPlugin");
  tflite_flutter_helper_plugin_register_with_registrar(tflite_flutter_helper_registrar);
  g_autoptr(FlPluginRegistrar) url_launcher_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UrlLauncherPlugin");
  url_launcher_plugin_register_with_registrar(url_launcher_linux_registrar);
}
