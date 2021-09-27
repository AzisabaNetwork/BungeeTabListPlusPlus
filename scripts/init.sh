#!/usr/bin/env bash
source ./scripts/functions.sh
(
  echo "Updating submodules" &&
  git submodule update --init &&
  cd work/BungeeTabListPlus &&
  git checkout $BRANCH &&
  git reset --hard origin/$BRANCH &&
  git submodule update --init &&
  cd ../../.. &&
  echo "Updated all submodules"
) || exit 1
