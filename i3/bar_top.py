#!/usr/bin/env python
# -*- coding: utf-8 -*-

import i3pystatus

status = i3pystatus.Status(standalone=True)

status.register("clock",
                format="%a %-d %b %X",)

status.register("load")

status.register("temp",
                format="{temp:.0f}°C",)

status.register("pulseaudio",
                format="♪{volume}",)

status.register("mpd",
                format="{title}{status}",
                status={
                    "pause": "▷",
                    "play": "▶",
                    "stop": "◾",
                },)


status.run()
