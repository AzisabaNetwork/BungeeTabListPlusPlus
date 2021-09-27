#!/usr/bin/env bash
source ./scripts/functions.sh
basedir="$(pwd -P)"
git="git -c commit.gpgsign=false"
apply="$git am --3way --ignore-whitespace"
windows="$([[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" ]] && echo "true" || echo "false")"
mkdir -p "$basedir/BungeeTabListPlus-Patches"
echo "Resetting BungeeTabListPlus..."
mkdir -p "$basedir/BungeeTabListPlus"
cd "$basedir/BungeeTabListPlus" || exit 1
$git init
$git remote rm upstream > /dev/null 2>&1
$git remote add upstream "$basedir/work/BungeeTabListPlus" >/dev/null 2>&1
$git checkout $BRANCH 2>/dev/null || $git checkout -b $BRANCH
$git fetch upstream >/dev/null 2>&1
$git reset --hard upstream/$BRANCH
cd "$basedir/BungeeTabListPlus/TabOverlayCommon" || exit 1
$git init
$git remote rm upstream > /dev/null 2>&1
$git remote add upstream "$basedir/work/BungeeTabListPlus/TabOverlayCommon" >/dev/null 2>&1
$git checkout $BRANCH 2>/dev/null || $git checkout -b $BRANCH
$git fetch upstream >/dev/null 2>&1
$git reset --hard upstream/$BRANCH
cd "$basedir/BungeeTabListPlus/minecraft-data-api" || exit 1
$git init
$git remote rm upstream > /dev/null 2>&1
$git remote add upstream "$basedir/work/BungeeTabListPlus/minecraft-data-api" >/dev/null 2>&1
$git checkout $BRANCH 2>/dev/null || $git checkout -b $BRANCH
$git fetch upstream >/dev/null 2>&1
$git reset --hard upstream/$BRANCH
# --- TabOverlayCommon
cd "$basedir/BungeeTabListPlus/TabOverlayCommon" || exit 1
echo "  Applying patches to TabOverlayCommon..."
$git am --abort >/dev/null 2>&1
if [[ $windows == "true" ]]; then
  echo "  Using workaround for Windows ARG_MAX constraint"
  find "$basedir/TabOverlayCommon-Patches/"*.patch -print0 | xargs -0 $apply
else
  $apply "$basedir/TabOverlayCommon-Patches/"*.patch
fi
if [ "$?" != "0" ]; then
  echo "  Something did not apply cleanly to TabOverlayCommon."
  echo "  Please review above details and finish the apply then"
  echo "  save the changes with rebuildPatches.sh"
  #if [[ $windows == "true" ]]; then
  #  echo ""
  #  echo "  Because you're on Windows you'll need to finish the AM,"
  #  echo "  rebuild all patches, and then re-run the patch apply again."
  #  echo "  Consider using the scripts with Windows Subsystem for Linux."
  #fi
  exit 1
else
  echo "  Patches applied cleanly to TabOverlayCommon"
fi
# --- minecraft-data-api
cd ../minecraft-data-api || exit 1
echo "  Applying patches to minecraft-data-api..."
$git am --abort >/dev/null 2>&1
if [[ $windows == "true" ]]; then
  echo "  Using workaround for Windows ARG_MAX constraint"
  find "$basedir/minecraft-data-api-Patches/"*.patch -print0 | xargs -0 $apply
else
  $apply "$basedir/minecraft-data-api-Patches/"*.patch
fi
if [ "$?" != "0" ]; then
  echo "  Something did not apply cleanly to minecraft-data-api."
  echo "  Please review above details and finish the apply then"
  echo "  save the changes with rebuildPatches.sh"
  #if [[ $windows == "true" ]]; then
  #  echo ""
  #  echo "  Because you're on Windows you'll need to finish the AM,"
  #  echo "  rebuild all patches, and then re-run the patch apply again."
  #  echo "  Consider using the scripts with Windows Subsystem for Linux."
  #fi
  exit 1
else
  echo "  Patches applied cleanly to minecraft-data-api"
fi
# --- BungeeTabListPlus
#cd .. || exit 1
#echo "  Applying patches to BungeeTabListPlus..."
#$git am --abort >/dev/null 2>&1
#if [[ $windows == "true" ]]; then
#  echo "  Using workaround for Windows ARG_MAX constraint"
#  find "$basedir/BungeeTabListPlus-Patches/"*.patch -print0 | xargs -0 $apply
#else
#  $apply "$basedir/BungeeTabListPlus-Patches/"*.patch
#fi
#if [ "$?" != "0" ]; then
#  echo "  Something did not apply cleanly to BungeeTabListPlus."
#  echo "  Please review above details and finish the apply then"
#  echo "  save the changes with rebuildPatches.sh"
#  #if [[ $windows == "true" ]]; then
#  #  echo ""
#  #  echo "  Because you're on Windows you'll need to finish the AM,"
#  #  echo "  rebuild all patches, and then re-run the patch apply again."
#  #  echo "  Consider using the scripts with Windows Subsystem for Linux."
#  #fi
#  exit 1
#else
#  echo "  Patches applied cleanly to BungeeTabListPlus"
#fi
