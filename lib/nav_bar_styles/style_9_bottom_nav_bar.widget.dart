part of persistent_bottom_nav_bar;

class _BottomNavStyle9 extends StatelessWidget {
  const _BottomNavStyle9({
    required this.navBarEssentials,
    final Key? key,
  }) : super(key: key);
  final _NavBarEssentials navBarEssentials;

  Widget _buildItem(final PersistentBottomNavBarItem item,
          final bool isSelected, final double? height) =>
      navBarEssentials.navBarHeight == 0
          ? const SizedBox.shrink()
          : AnimatedContainer(
              width: 90,
              height: height! / 1.5,
              duration: navBarEssentials.itemAnimationProperties.duration,
              curve: navBarEssentials.itemAnimationProperties.curve,
              padding: EdgeInsets.all(item.contentPadding),
              decoration: BoxDecoration(
                color: isSelected
                    ? item.activeColorPrimary.withOpacity(0.15)
                    : navBarEssentials.backgroundColor.withOpacity(0),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                alignment: Alignment.center,
                height: height / 1.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconTheme(
                      data: IconThemeData(
                          size: item.iconSize,
                          color: isSelected
                              ? (item.activeColorSecondary ??
                                  item.activeColorPrimary)
                              : item.inactiveColorPrimary ??
                                  item.activeColorPrimary),
                      child: isSelected
                          ? item.icon
                          : item.inactiveIcon ?? item.icon,
                    ),
                    if (item.title != null)
                      const SizedBox(width: 8),
                    if (item.title == null)
                      const SizedBox.shrink()
                    else
                      isSelected
                          ? Flexible(
                              child: Material(
                                type: MaterialType.transparency,
                                child: FittedBox(
                                  child: Text(
                                    item.title!,
                                    style: item.textStyle != null
                                        ? (item.textStyle!.apply(
                                            color: isSelected
                                                ? (item.activeColorSecondary ??
                                                    item.activeColorPrimary)
                                                : item.inactiveColorPrimary))
                                        : TextStyle(
                                            color: item.activeColorSecondary ??
                                                item.activeColorPrimary,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink()
                  ],
                ),
              ),
            );

  @override
  Widget build(final BuildContext context) => Container(
        width: double.infinity,
        height: navBarEssentials.navBarHeight,
        padding: navBarEssentials.padding,
        child: Row(
          mainAxisAlignment: navBarEssentials.navBarItemsAlignment,
          children: navBarEssentials.items.map((final item) {
            final int index = navBarEssentials.items.indexOf(item);
            return Flexible(
              flex: navBarEssentials.selectedIndex == index ? 2 : 1,
              child: GestureDetector(
                onTap: () {
                  if (index != navBarEssentials.selectedIndex) {
                    navBarEssentials.items[index].iconAnimationController
                        ?.forward();
                    navBarEssentials.items[navBarEssentials.selectedIndex]
                        .iconAnimationController
                        ?.reverse();
                  }
                  if (navBarEssentials.items[index].onPressed != null) {
                    navBarEssentials.items[index].onPressed!(
                        navBarEssentials.selectedScreenBuildContext);
                  } else {
                    navBarEssentials.onItemSelected?.call(index);
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  child: _buildItem(
                      item,
                      navBarEssentials.selectedIndex == index,
                      navBarEssentials.navBarHeight),
                ),
              ),
            );
          }).toList(),
        ),
      );
}
