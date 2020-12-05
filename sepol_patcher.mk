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

SEPOL_PATH := "system/sepolicy"
DEVICE_PATH := "device/xiaomi/laurel_sprout"
PATCH_FILE := "0001-Revert-sepolicy-Address-denials-for-legacy-last_kmsg.patch"

SHELL_RESULT := $(shell cp $(DEVICE_PATH)/$(PATCH_FILE) $(SEPOL_PATH) && cd $(SEPOL_PATH) && git am $(PATCH_FILE) && rm $(PATCH_FILE) && cd -)
