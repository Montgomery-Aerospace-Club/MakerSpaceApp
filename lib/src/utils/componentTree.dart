import 'package:themakerspace/src/models/building.dart';
import 'package:themakerspace/src/models/component.dart';
import 'package:themakerspace/src/models/component_list.dart';
import 'package:themakerspace/src/models/room.dart';
import 'package:themakerspace/src/models/storage_bin.dart';
import 'package:themakerspace/src/models/storage_unit.dart';

List<dynamic> generateTree(ComponentList complst) {
  // Map<Building, Map<Room, Map<StorageUnit, Map<StorageBin, List<Component>>>>>
  //     ret = {};
  var ret = [];

  // for (Component comp in complst.components) {
  //   List<StorageBin> bins = comp.storageBins;
  //   for (StorageBin bin in bins) {
  //     StorageUnit unit = bin.storageUnit;
  //     Room room = unit.room;
  //     Building build = room.building;

  //     // Check if the keys exist in the nested maps and initialize them if needed.
  //     ret[build] ??= {};
  //     ret[build]![room] ??= {};
  //     ret[build]![room]![unit] ??= {};
  //     ret[build]![room]![unit]![bin] ??= [];

  //     // Add comp to the list associated with the bin.
  //     ret[build]![room]![unit]![bin]!.add(comp);
  //   }
  // }
  for (Component comp in complst.components) {
    List<StorageBin> bins = comp.storageBins;
    for (StorageBin bin in bins) {
      StorageUnit unit = bin.storageUnit;
      Room room = unit.room;
      Building build = room.building;

      bin.addChild(comp);
      unit.addChild(bin);
      room.addChild(unit);
      build.addChild(room);

      ret.add(build);
    }
  }

  return ret;
}

/*
/// Control item to expand or collapse
/// [index] The index of the selected item
_controller.expandOrCollapse(index);

/// select only itself
_controller.selectItem(item);

/// Select itself and all child nodes
_controller.selectAllChild(item);
*/