/*
 * Copyright (C) 2016 Konsulko Group
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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <errno.h>
#include <unistd.h>
#include <limits.h>
#include <assert.h>

#include <pulse/pulseaudio.h>

#include "model.h"
#include "pac.h"

static pa_threaded_mainloop* m;

static void get_source_list_cb(pa_context *c,
		const pa_source_info *i,
		int eol,
		void *data)
{
	if (eol < 0) {
		fprintf(stderr, "get source list: %s\n",
				pa_strerror(pa_context_errno(c)));

		pa_threaded_mainloop_stop(m);
		return;
	}

	if (!eol) {
		assert(i);
		add_one_control(data, i->index, i->description,
				C_SOURCE, i->volume.channels,
				i->volume.values[0]);
	}
}

static void get_sink_list_cb(pa_context *c,
		const pa_sink_info *i,
		int eol,
		void *data)
{
	if(eol < 0) {
		fprintf(stderr, "get sink list: %s\n",
				pa_strerror(pa_context_errno(c)));

		pa_threaded_mainloop_stop(m);
		return;
	}

	if(!eol) {
		assert(i);
		add_one_control(data, i->index, i->description,
				C_SINK, i->volume.channels,
				i->volume.values[0]);
	}
}

static void context_state_cb(pa_context *c, void *data) {
	pa_operation *o;

	assert(c);
	switch (pa_context_get_state(c)) {
		case PA_CONTEXT_CONNECTING:
		case PA_CONTEXT_AUTHORIZING:
		case PA_CONTEXT_SETTING_NAME:
			break;
		case PA_CONTEXT_READY:
			/* Fetch the controls of interest */
			if (!(o = pa_context_get_source_info_list(c, get_source_list_cb, data))) {
				fprintf(stderr, "get source info list: %s\n",
					pa_strerror(pa_context_errno(c)));
				return;
			}
			pa_operation_unref(o);
			if (!(o = pa_context_get_sink_info_list(c, get_sink_list_cb, data))) {
				fprintf(stderr, "get sink info list: %s\n",
					pa_strerror(pa_context_errno(c)));
				return;
			}
			break;
		case PA_CONTEXT_TERMINATED:
			pa_threaded_mainloop_stop(m);
			break;
		case PA_CONTEXT_FAILED:
		default:
			fprintf(stderr, "PA connection failed: %s\n",
					pa_strerror(pa_context_errno(c)));
			pa_threaded_mainloop_stop(m);
	}
}

static void pac_set_source_volume_cb(pa_context *c, int success, void *userdata) {
	assert(c);
	pa_xfree(userdata);
	if (!success)
		fprintf(stderr, "Set source volume: %s\n",
				pa_strerror(pa_context_errno(c)));
}

static void pac_set_sink_volume_cb(pa_context *c, int success, void *userdata) {
	assert(c);
	pa_xfree(userdata);
	if (!success)
		fprintf(stderr, "Set source volume: %s\n",
				pa_strerror(pa_context_errno(c)));
}

void pac_set_volume(pa_context *c, uint32_t type, uint32_t idx, uint32_t channels, uint32_t volume)
{
	pa_operation *o;
	pa_cvolume *cv = pa_xnew(pa_cvolume, 1);
	cv->channels = channels;
	cv->values[0] = cv->values[1] = volume;

	if (type == C_SOURCE) {
		if (!(o = pa_context_set_source_volume_by_index(c, idx, cv, pac_set_source_volume_cb, (void *)cv))) {
			fprintf(stderr, "set source volume: %s\n",
					pa_strerror(pa_context_errno(c)));
			return;
		}
		pa_operation_unref(o);
	} else if (type == C_SINK) {
		if (!(o = pa_context_set_sink_volume_by_index(c, idx, cv, pac_set_sink_volume_cb, (void *)cv))) {
			fprintf(stderr, "set sink volume: %s\n",
					pa_strerror(pa_context_errno(c)));
			return;
		}
		pa_operation_unref(o);
	}
}

pa_context *pac_init(void *this, const char *name) {
	pa_context *c;
	pa_mainloop_api *mapi;
	char *server = NULL;
	char *client = pa_xstrdup(name);

	if (!(m = pa_threaded_mainloop_new())) {
		fprintf(stderr, "pa_mainloop_new() failed.\n");
		return NULL;
	}

	pa_threaded_mainloop_set_name(m, "pa_mainloop");
	mapi = pa_threaded_mainloop_get_api(m);

	if (!(c = pa_context_new(mapi, client))) {
		fprintf(stderr, "pa_context_new() failed.\n");
		goto exit;
	}

	pa_context_set_state_callback(c, context_state_cb, this);
	if (pa_context_connect(c, server, 0, NULL) < 0) {
		fprintf(stderr, "pa_context_connect(): %s", pa_strerror(pa_context_errno(c)));
		goto exit;
	}

	if (pa_threaded_mainloop_start(m) < 0) {
		fprintf(stderr, "pa_mainloop_run() failed.\n");
		goto exit;
	}

	return c;

exit:
	if (c)
		pa_context_unref(c);

	if (m)
		pa_threaded_mainloop_free(m);

	pa_xfree(client);

	return NULL;
}
