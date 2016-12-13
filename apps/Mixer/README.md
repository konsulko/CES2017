PulseAudio mixer application
----------------------------

This simple mixer supports the following features:

* Supports all reported sinks and sources
* Supports a per-sink/source volume control slider

Limitations:

* No source-output or sink-input support
* No independent channel volume control
* No mute toggle support
* No logarithmic volume control
* No event support (does not listen or respond to PA events from other clients)
* Does not check actual volume range
