/*
 * Copyright (C) 2019 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "FingerprintInscreenService"

#include "FingerprintInscreen.h"

#include <android-base/logging.h>
#include <fstream>
#include <cmath>

#define FINGERPRINT_ERROR_VENDOR 8

#define COMMAND_NIT 10
#define PARAM_NIT_FOD 3
#define PARAM_NIT_NONE 0

#define DISPPARAM_PATH "/sys/devices/platform/soc/5e00000.qcom,mdss_mdp/drm/card0/card0-DSI-1/disp_param"
#define DISPPARAM_HBM_FOD_ON "0x1D20000"
#define DISPPARAM_HBM_FOD_OFF "0x20F0000"

#define FOD_STATUS_PATH "/sys/class/touch/tp_dev/fod_status"
#define FOD_STATUS_ON 1
#define FOD_STATUS_OFF 0

#define FOD_SENSOR_X 293
#define FOD_SENSOR_Y 1356
#define FOD_SENSOR_SIZE 134

namespace {

template <typename T>
static void set(const std::string& path, const T& value) {
    std::ofstream file(path);
    file << value;
}

} // anonymous namespace

namespace vendor {
namespace lineage {
namespace biometrics {
namespace fingerprint {
namespace inscreen {
namespace V1_0 {
namespace implementation {

FingerprintInscreen::FingerprintInscreen() {
    xiaomiFingerprintService = IXiaomiFingerprint::getService();
}

Return<int32_t> FingerprintInscreen::getPositionX() {
    return FOD_SENSOR_X;
}

Return<int32_t> FingerprintInscreen::getPositionY() {
    return FOD_SENSOR_Y;
}

Return<int32_t> FingerprintInscreen::getSize() {
    return FOD_SENSOR_SIZE;
}

Return<void> FingerprintInscreen::onStartEnroll() {
    return Void();
}

Return<void> FingerprintInscreen::onFinishEnroll() {
    return Void();
}

Return<void> FingerprintInscreen::onPress() {
    set(DISPPARAM_PATH, DISPPARAM_HBM_FOD_ON);
    xiaomiFingerprintService->extCmd(COMMAND_NIT, PARAM_NIT_FOD);
    return Void();
}

Return<void> FingerprintInscreen::onRelease() {
    set(DISPPARAM_PATH, DISPPARAM_HBM_FOD_OFF);
    xiaomiFingerprintService->extCmd(COMMAND_NIT, PARAM_NIT_NONE);
    return Void();
}

Return<void> FingerprintInscreen::onShowFODView() {
    set(FOD_STATUS_PATH, FOD_STATUS_ON);
    return Void();
}

Return<void> FingerprintInscreen::onHideFODView() {
    set(FOD_STATUS_PATH, FOD_STATUS_OFF);
    set(DISPPARAM_PATH, DISPPARAM_HBM_FOD_OFF);
    return Void();
}

Return<bool> FingerprintInscreen::handleAcquired(int32_t acquiredInfo, int32_t vendorCode) {

    LOG(ERROR) << "acquiredInfo: " << acquiredInfo << ", vendorCode: " << vendorCode << "\n";

    std::lock_guard<std::mutex> _lock(mCallbackLock);
    if (mCallback == nullptr) {
        return false;
    }

    if (acquiredInfo == FINGERPRINT_ACQUIRED_VENDOR) {
        if (vendorCode == 22) {
            Return<void> ret = mCallback->onFingerDown();
            if (!ret.isOk()) {
                LOG(ERROR) << "FingerDown() error: " << ret.description();
            }
            return true;
        }

        if (vendorCode == 23) {
            Return<void> ret = mCallback->onFingerUp();
            if (!ret.isOk()) {
                LOG(ERROR) << "FingerUp() error: " << ret.description();
            }
            return true;
        }
    }

    return false;
}

Return<bool> FingerprintInscreen::handleError(int32_t error, int32_t vendorCode) {
    LOG(ERROR) << "error: " << error << ", vendorCode: " << vendorCode << "\n";
    return error == FINGERPRINT_ERROR_VENDOR && vendorCode == 6;
}

Return<void> FingerprintInscreen::setLongPressEnabled(bool) {
    return Void();
}

Return<int32_t> FingerprintInscreen::getDimAmount(int32_t brightness) {
    float alpha;

    if (brightness > 62) {
        alpha = 1.0 - pow(brightness / 255.0 * 430.0 / 600.0, 0.45);
    } else {
        alpha = 1.0 - pow(brightness / 200.0, 0.45);
    }

    return 255 * alpha;
}

Return<bool> FingerprintInscreen::shouldBoostBrightness() {
    return false;
}

Return<void> FingerprintInscreen::setCallback(const sp<IFingerprintInscreenCallback>& /* callback */) {
    return Void();
}

}  // namespace implementation
}  // namespace V1_0
}  // namespace inscreen
}  // namespace fingerprint
}  // namespace biometrics
}  // namespace lineage
}  // namespace vendor
