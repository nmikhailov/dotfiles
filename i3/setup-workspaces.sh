#!/bin/sh
i3-msg "workspace $1; append_layout $HOME/.i3/workspaces/chat.json"
i3-msg "workspace $2"

