/*
 * Copyright (c) 2013, The Linux Foundation. All rights reserved.
 * Copyright (C) 2018-2021 The LineageOS Project
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * *    * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above
 *       copyright notice, this list of conditions and the following
 *       disclaimer in the documentation and/or other materials provided
 *       with the distribution.
 *     * Neither the name of The Linux Foundation nor the names of its
 *       contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
 * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#define LOG_NIDEBUG 0

#include <dlfcn.h>
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>

#define LOG_TAG "QCOM PowerHAL"
#include <hardware/hardware.h>
#include <hardware/power.h>
#include <log/log.h>

#include "hint-data.h"
#include "metadata-defs.h"
#include "performance.h"
#include "power-common.h"
#include "utils.h"

/**
 * Returns true if the target is APQ8064.
 */
static bool is_target_8064(void) {
    static int is_8064 = -1;
    int soc_id;

    if (is_8064 >= 0) return is_8064;

    soc_id = get_soc_id();
    is_8064 = soc_id == 153;

    return is_8064;
}

static int current_power_profile = PROFILE_BALANCED;

// clang-format off
static int profile_high_performance_8960[] = {
    CPUS_ONLINE_MIN_2,
};

static int profile_high_performance_8064[] = {
    CPUS_ONLINE_MIN_4,
};

static int profile_power_save_8960[] = {
    /* Don't do anything for now */
};

static int profile_power_save_8064[] = {
    CPUS_ONLINE_MAX_LIMIT_2,
};
// clang-format on

#ifdef INTERACTION_BOOST
int get_number_of_profiles() {
    return 3;
}
#endif

void set_power_profile(int profile) {
    int ret = -EINVAL;
    const char* profile_name = NULL;

    if (profile == current_power_profile) return;

    ALOGV("%s: Profile=%d", __func__, profile);

    if (current_power_profile != PROFILE_BALANCED) {
        undo_hint_action(DEFAULT_PROFILE_HINT_ID);
        ALOGV("%s: Hint undone", __func__);
        current_power_profile = PROFILE_BALANCED;
    }

    if (profile == PROFILE_POWER_SAVE) {
        if (is_target_8064()) {
            ret = perform_hint_action(DEFAULT_PROFILE_HINT_ID, profile_power_save_8064,
                                      ARRAY_SIZE(profile_power_save_8064));
        } else {
            ret = perform_hint_action(DEFAULT_PROFILE_HINT_ID, profile_power_save_8960,
                                      ARRAY_SIZE(profile_power_save_8960));
        }
        profile_name = "powersave";
    } else if (profile == PROFILE_HIGH_PERFORMANCE) {
        if (is_target_8064()) {
            ret = perform_hint_action(DEFAULT_PROFILE_HINT_ID, profile_high_performance_8064,
                                      ARRAY_SIZE(profile_high_performance_8064));
        } else {
            ret = perform_hint_action(DEFAULT_PROFILE_HINT_ID, profile_high_performance_8960,
                                      ARRAY_SIZE(profile_high_performance_8960));
        }
        profile_name = "performance";
    } else if (profile == PROFILE_BALANCED) {
        ret = 0;
        profile_name = "balanced";
    }

    if (ret == 0) {
        current_power_profile = profile;
        ALOGD("%s: Set %s mode", __func__, profile_name);
    } else {
        ALOGE("Setting power profile failed. perfd not started?");
    }
}

static int process_video_encode_hint(void* metadata) {
    char governor[80];
    struct video_encode_metadata_t video_encode_metadata;

    if (!metadata) return HINT_NONE;

    if (get_scaling_governor(governor, sizeof(governor)) == -1) {
        ALOGE("Can't obtain scaling governor.");
        return HINT_NONE;
    }

    /* Initialize encode metadata struct fields */
    memset(&video_encode_metadata, 0, sizeof(struct video_encode_metadata_t));
    video_encode_metadata.state = -1;
    video_encode_metadata.hint_id = DEFAULT_VIDEO_ENCODE_HINT_ID;

    if (parse_video_encode_metadata((char*)metadata, &video_encode_metadata) == -1) {
        ALOGE("Error occurred while parsing metadata.");
        return HINT_NONE;
    }

    if (video_encode_metadata.state == 1) {
        if (is_interactive_governor(governor)) {
            int resource_values[] = {TR_MS_30, HISPEED_LOAD_90, HS_FREQ_1026,
                                     THREAD_MIGRATION_SYNC_OFF, INTERACTIVE_IO_BUSY_OFF};
            perform_hint_action(video_encode_metadata.hint_id, resource_values,
                                ARRAY_SIZE(resource_values));
            return HINT_HANDLED;
        }
    } else if (video_encode_metadata.state == 0) {
        if (is_interactive_governor(governor)) {
            undo_hint_action(video_encode_metadata.hint_id);
            return HINT_HANDLED;
        }
    }
    return HINT_NONE;
}

static int process_video_decode_hint(void* metadata) {
    char governor[80];
    struct video_decode_metadata_t video_decode_metadata;

    if (!metadata) return HINT_NONE;

    if (get_scaling_governor(governor, sizeof(governor)) == -1) {
        ALOGE("Can't obtain scaling governor.");
        return HINT_NONE;
    }

    /* Initialize encode metadata struct fields */
    memset(&video_decode_metadata, 0, sizeof(struct video_decode_metadata_t));
    video_decode_metadata.state = -1;
    video_decode_metadata.hint_id = DEFAULT_VIDEO_DECODE_HINT_ID;

    if (parse_video_decode_metadata((char*)metadata, &video_decode_metadata) == -1) {
        ALOGE("Error occurred while parsing metadata.");
        return HINT_NONE;
    }

    if (video_decode_metadata.state == 1) {
        if (is_interactive_governor(governor)) {
            int resource_values[] = {TR_MS_30, HISPEED_LOAD_90, HS_FREQ_1026,
                                     THREAD_MIGRATION_SYNC_OFF};
            perform_hint_action(video_decode_metadata.hint_id, resource_values,
                                ARRAY_SIZE(resource_values));
            return HINT_HANDLED;
        }
    } else if (video_decode_metadata.state == 0) {
        if (is_interactive_governor(governor)) {
            undo_hint_action(video_decode_metadata.hint_id);
            return HINT_HANDLED;
        }
    }
    return HINT_NONE;
}

int power_hint_override(power_hint_t hint, void* data) {
    int ret_val = HINT_NONE;

    // Skip other hints in high/low power modes
    if (current_power_profile == PROFILE_POWER_SAVE ||
        current_power_profile == PROFILE_HIGH_PERFORMANCE) {
        return HINT_HANDLED;
    }

    switch (hint) {
        case POWER_HINT_VIDEO_ENCODE:
            ret_val = process_video_encode_hint(data);
            break;
        case POWER_HINT_VIDEO_DECODE:
            ret_val = process_video_decode_hint(data);
            break;
        default:
            break;
    }
    return ret_val;
}

int set_interactive_override(int on) {
    char governor[80];

    if (get_scaling_governor(governor, sizeof(governor)) == -1) {
        ALOGE("Can't obtain scaling governor.");
        return HINT_NONE;
    }

    if (!on) {
        /* Display off */
        if (is_interactive_governor(governor)) {
            int resource_values[] = {TR_MS_50, THREAD_MIGRATION_SYNC_OFF};
            perform_hint_action(DISPLAY_STATE_HINT_ID, resource_values,
                                ARRAY_SIZE(resource_values));
        }
    } else {
        /* Display on */
        if (is_interactive_governor(governor)) {
            undo_hint_action(DISPLAY_STATE_HINT_ID);
        }
    }
    return HINT_HANDLED;
}
