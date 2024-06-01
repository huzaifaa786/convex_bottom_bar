/*
 *  Copyright 2020 Chaobin Wu <chaobinwu89@gmail.com>
 *  
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  
 *      http://www.apache.org/licenses/LICENSE-2.0
 *  
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

import 'package:flutter/material.dart';

import '../item.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';

/// A style builder for a fixed tab with a centered convex shape.
///
/// This class is used to create a tab style where a specific tab is highlighted
/// with a convex shape. The highlighted tab is always centered.
///
/// The `FixedTabStyle` class extends [InnerBuilder] and overrides the
/// [build] and [fixed] methods to provide a custom implementation.
///
/// Example usage:
/// ```dart
/// FixedTabStyle(
///   items: [
///     TabItem(icon: Icons.home, title: 'Home'),
///     TabItem(icon: Icons.search, title: 'Search'),
///     TabItem(icon: Icons.person, title: 'Profile'),
///   ],
///   activeColor: Colors.blue,
///   color: Colors.grey,
///   convexIndex: 1,
///   textStyle: TextStyle(color: Colors.black),
///   centerTextStyle: TextStyle(color: Colors.red),
///   selectedTextStyle: TextStyle(color: Colors.green),
///   iconSize: 24.0,
///   centerIconSized: 34.0,
/// );
/// ```
class FixedTabStyle extends InnerBuilder {
  /// Index of the centered convex shape.
  final int convexIndex;

  /// Size of the icon.
  final double iconSize;

  /// Size of the centered icon.
  final double centerIconSized;

  /// Style of the text.
  final TextStyle textStyle;

  /// Style of the text for the centered tab.
  final TextStyle centerTextStyle;

  /// Style of the text for the selected tab.
  final TextStyle selectedTextStyle;

  /// Creates a [FixedTabStyle] instance.
  ///
  /// The [items], [activeColor], [color], [convexIndex], [textStyle], [centerTextStyle], [selectedTextStyle], [iconSize], and
  /// [centerIconSized] parameters must not be null.
  FixedTabStyle({
    required List<TabItem> items,
    required Color activeColor,
    required Color color,
    required this.convexIndex,
    required this.textStyle,
    required this.centerTextStyle,
    required this.selectedTextStyle,
    required this.iconSize,
    required this.centerIconSized,
  }) : super(items: items, activeColor: activeColor, color: color);

  /// Builds the widget for a tab item.
  ///
  /// The [context] is the build context.
  /// The [index] is the index of the tab item.
  /// The [active] indicates if the tab item is active.
  ///
  /// Returns a [Widget] representing the tab item.
  @override
  Widget build(BuildContext context, int index, bool active) {
    var c = active ? activeColor : color;
    var item = items[index];

    if (index == convexIndex) {
      var item = items[convexIndex];
      return Container(
        padding: EdgeInsets.only(bottom: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            BlendImageIcon(
              active ? item.activeIcon ?? item.icon : item.icon,
              color: item.blend ? (c) : null,
              size: index == 2 ? centerIconSized : iconSize,
            ),
            Text(item.title ?? '',
                style: active
                    ? selectedTextStyle
                    : index == 2
                        ? centerTextStyle
                        : textStyle),
          ],
        ),
      );
    }

    var icon = BlendImageIcon(
      active ? item.activeIcon ?? item.icon : item.icon,
      size: index == 2 ? centerIconSized : iconSize,
      color: item.blend ? (c) : null,
    );
    var children = <Widget>[
      icon,
      Text(item.title ?? '',
          style: active
              ? selectedTextStyle
              : index == 2
                  ? centerTextStyle
                  : textStyle)
    ];
    return Container(
      padding: EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: children,
      ),
    );
  }

  /// Indicates whether the tab is fixed.
  ///
  /// This method always returns `true` for [FixedTabStyle].
  @override
  bool fixed() {
    return true;
  }
}
