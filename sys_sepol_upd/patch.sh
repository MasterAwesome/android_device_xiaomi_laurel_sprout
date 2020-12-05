#!/bin/bash
# Copyright (C) 2020 Arvind Mukund<armu30@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

SEPOL_PATH="system/sepolicy"
DEVICE_PATH="device/xiaomi/laurel_sprout/sys_sepol_upd"
PATCH_FILE="0001-Revert-sepolicy-Address-denials-for-legacy-last_kmsg.patch"

cleanup() {
	rm "$PATCH_FILE"
	git am --abort
	cd -
}

if [ ! -f "${DEVICE_PATH}/${PATCH_FILE}" ]; then
	echo "Patch file missing! Skipping patching!"
	exit 0
fi

cp "$DEVICE_PATH/$PATCH_FILE" "$SEPOL_PATH"
cd "$SEPOL_PATH"

# Commit message identifier. (FOR NOW THIS WILL DO)
IS_THERE=$(git log --grep "1188affe377931f31b6f85d8851c3ddf00ab5567" | wc -l)
if [ $IS_THERE -gt 0 ]; then
	cleanup
	exit 0
fi

# We haven't found a patch and we have the fix for it!
git am "$PATCH_FILE" &> /dev/null
RET="$?"

if [ $RET -ne 0 ]; then
	echo "Open an Issue on https://github.com/MasterAwesome/android_device_xiaomi_laurel_sprout.git"
	cleanup
	exit 1
fi

exit 0;
