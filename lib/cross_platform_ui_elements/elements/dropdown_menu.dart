import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as windows;

class CPDropdownMenu<T> extends StatelessWidget {
  const CPDropdownMenu({
    super.key,
    required this.items,
    this.initialIndex = 0,
    required this.onSelected,
    this.onCanceled,
    this.tooltip,
    this.elevation,
    this.padding = const EdgeInsets.all(8.0),
    this.child,
    this.icon,
    this.iconSize,
    this.offset = Offset.zero,
    this.enabled = true,
    this.shape,
    this.color,
    this.enableFeedback,
    this.leading,
    this.title,
    this.trailing,
    this.closeAfterClick = true,
    this.disabled = false,
    this.focusNode,
    this.autofocus = false,
    this.buttonStyle,
    this.placement = windows.FlyoutPlacementMode.topCenter,
    this.menuDecoration,
    this.dropdownButton,
  });

  final List<CPDropDownButtonItem> items;
  final int initialIndex;
  final void Function(CPDropDownButtonItem) onSelected;
  final PopupMenuCanceled? onCanceled;
  final String? tooltip;
  final double? elevation;
  final EdgeInsetsGeometry padding;
  final Widget? child;
  final Widget? icon;
  final Offset offset;
  final bool enabled;
  final ShapeBorder? shape;
  final Color? color;
  final bool? enableFeedback;
  final double? iconSize;

  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final bool closeAfterClick;
  final bool disabled;
  final FocusNode? focusNode;
  final bool autofocus;
  final windows.ButtonStyle? buttonStyle;
  final windows.FlyoutPlacementMode placement;
  final Decoration? menuDecoration;
  final DropdownButton? dropdownButton;

  @override
  Widget build(BuildContext context) {
    return Platform.isWindows
        ? windows.DropDownButton(
            key: key,
            items: items
                .map((e) => windows.MenuFlyoutItem(
                      trailing: e.trailing,
                      leading: e.leading,
                      key: e.key,
                      onPressed: () {},
                      text: e,
                    ))
                .toList(),
            leading: leading,
            title: title,
            trailing: trailing,
            closeAfterClick: closeAfterClick,
            disabled: disabled,
            focusNode: focusNode,
            autofocus: autofocus,
            // Removed buttonStyle as it is not defined
            placement: placement,
          )
        : PopupMenuButton<CPDropDownButtonItem>(
            key: key,
            itemBuilder: (context) => List.generate(
                items.length, (index) => PopupMenuItem(child: items[index])),
            initialValue: items[initialIndex],
            onSelected: onSelected,
            onCanceled: onCanceled,
            tooltip: tooltip,
            elevation: elevation,
            padding: padding,
            icon: icon,
            iconSize: iconSize,
            offset: offset,
            enabled: enabled,
            shape: shape,
            color: color,
            enableFeedback: enableFeedback,
            child: child,
          );
  }
}

/// An item used by [DropDownButton].
class CPDropDownButtonItem extends windows.StatelessWidget {
  /// Creates a drop down button item
  const CPDropDownButtonItem({
    super.key,
    required this.onTap,
    this.leading,
    this.title,
    this.trailing,
  }) : assert(
          leading != null || title != null || trailing != null,
          'You must provide at least one property: leading, title or trailing',
        );

  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Platform.isWindows
        ? windows.DropDownButton(
            key: key,
            onOpen: onTap,
            leading: leading,
            title: title,
            trailing: trailing,
            items: [],
          ).buttonBuilder!(
            context,
            () {},
          )
        : PopupMenuItem(
            key: key,
            onTap: onTap,
            child: Row(
              children: [
                leading != null
                    ? leading!
                    : const SizedBox(width: 0, height: 0),
                title != null ? title! : const SizedBox(width: 0, height: 0),
                trailing != null
                    ? trailing!
                    : const SizedBox(width: 0, height: 0),
              ],
            ),
          );
  }
}
