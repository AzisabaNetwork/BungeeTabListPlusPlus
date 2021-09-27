#!/usr/bin/env bash
source ./scripts/functions.sh
basedir="$(pwd -P)"
git="git -c commit.gpgsign=false -c core.safecrlf=false"
# --- TabOverlayCommon
echo "Rebuilding patch files... (TabOverlayCommon)"
mkdir -p "$basedir/TabOverlayCommon-Patches"
mkdir -p "$basedir/minecraft-data-api-Patches"
mkdir -p "$basedir/BungeeTabListPlus-Patches"
cd "$basedir/TabOverlayCommon-Patches" || exit 1
rm -rf -- *.patch
cd "$basedir/BungeeTabListPlus/TabOverlayCommon" || exit 1
$git format-patch --zero-commit --full-index --no-signature --no-stat -N -o "$basedir/TabOverlayCommon-Patches/" upstream/$BRANCH >/dev/null
cd "$basedir" || exit 1
$git add -A "$basedir/TabOverlayCommon-Patches"
cd "$basedir/TabOverlayCommon-Patches" || exit 1
for patch in *.patch; do
  echo "$patch"
  diffs=$($git diff --staged "$patch" | grep --color=none -E "^(\+|\-)" | grep --color=none -Ev "(\-\-\- a|\+\+\+ b|^.index)")
  if [ "x$diffs" == "x" ] ; then
    $git restore "$patch" >/dev/null
    $git checkout -- "$patch" >/dev/null
  fi
done
echo "  Patches saved for TabOverlayCommon to TabOverlayCommon-Patches/"
# --- minecraft-data-api
echo "Rebuilding patch files... (minecraft-data-api)"
cd "$basedir/minecraft-data-api-Patches" || exit 1
rm -rf -- *.patch
cd "$basedir/BungeeTabListPlus/minecraft-data-api" || exit 1
$git format-patch --zero-commit --full-index --no-signature --no-stat -N -o "$basedir/minecraft-data-api-Patches/" upstream/$BRANCH >/dev/null
cd "$basedir" || exit 1
$git add -A "$basedir/minecraft-data-api-Patches"
cd "$basedir/minecraft-data-api-Patches" || exit 1
for patch in *.patch; do
  echo "$patch"
  diffs=$($git diff --staged "$patch" | grep --color=none -E "^(\+|\-)" | grep --color=none -Ev "(\-\-\- a|\+\+\+ b|^.index)")
  if [ "x$diffs" == "x" ] ; then
    $git restore "$patch" >/dev/null
    $git checkout -- "$patch" >/dev/null
  fi
done
echo "  Patches saved for minecraft-data-api to minecraft-data-api-Patches/"
# --- BungeeTabListPlus
echo "Rebuilding patch files... (BungeeTabListPlus)"
mkdir -p "$basedir/BungeeTabListPlus-Patches"
cd "$basedir/BungeeTabListPlus-Patches" || exit 1
rm -rf -- *.patch
cd "$basedir/BungeeTabListPlus" || exit 1
$git format-patch --zero-commit --full-index --no-signature --no-stat -N -o "$basedir/BungeeTabListPlus-Patches/" upstream/$BRANCH >/dev/null
cd "$basedir" || exit 1
$git add -A "$basedir/BungeeTabListPlus-Patches"
cd "$basedir/BungeeTabListPlus-Patches" || exit 1
for patch in *.patch; do
  echo "$patch"
  diffs=$($git diff --staged "$patch" | grep --color=none -E "^(\+|\-)" | grep --color=none -Ev "(\-\-\- a|\+\+\+ b|^.index)")
  if [ "x$diffs" == "x" ] ; then
    $git restore "$patch" >/dev/null
    $git checkout -- "$patch" >/dev/null
  fi
done
echo "  Patches saved for BungeeTabListPlus to BungeeTabListPlus-Patches/"
