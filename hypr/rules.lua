local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({
	name = "zen-picture-in-picture",
	match = {
		class = "zen",
		title = "Picture-in-Picture",
	},

	float = true,
	pin = true,
	persistent_size = true,
	no_initial_focus = true,
	content = "video",
	move = "((monitor_w*0.81)) ((monitor_h*0.81))",
	opacity = "override 1.0 override 1.0 override 1.0",
})

hl.window_rule({
	name = "zen-twitch-opacity",
	match = {
		class = "zen",
		title = ".+Twitch.+",
	},

	opacity = "override 1.0 override 1.0 override 1.0",
})

hl.window_rule({
	name = "zen-youtube-opacity",
	match = {
		class = "zen",
		title = ".+YouTube.+",
	},

	opacity = "override 1.0 override 1.0 override 1.0",
})

hl.window_rule({
	name = "helium-picture-in-picture",
	match = {
		class = "helium",
		title = "Picture-in-Picture",
	},

	float = true,
	pin = true,
	persistent_size = true,
	no_initial_focus = true,
	content = "video",
	move = "((monitor_w*0.81)) ((monitor_h*0.81))",
	opacity = "override 1.0 override 1.0 override 1.0",
})

hl.window_rule({
	name = "helium-picture-in-picture2",
	match = {
		title = "Picture in picture",
	},

	float = true,
	pin = true,
	persistent_size = true,
	no_initial_focus = true,
	content = "video",
	move = "((monitor_w*0.81)) ((monitor_h*0.81))",
	opacity = "override 1.0 override 1.0 override 1.0",
})

hl.window_rule({
	name = "helium-twitch-opacity",
	match = {
		class = "helium",
		title = ".+Twitch.+",
	},

	opacity = "override 1.0 override 1.0 override 1.0",
})

hl.window_rule({
	name = "helium-youtube-opacity",
	match = {
		class = "helium",
		title = ".+YouTube.+",
	},

	opacity = "override 1.0 override 1.0 override 1.0",
})

require("pip_position").setup()

hl.window_rule({
	name = "sinkswitch",
	match = {
		class = "com.mitchellh.ghostty",
		title = "ghostty-sinkswitch",
	},

	float = true,
	move = "3340 64",
	size = "480 160",
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

hl.layer_rule({
	name = "swaync-control-center-blur",
	match = { namespace = "swaync-control-center" },

	blur = true,
	ignore_alpha = 0.5,
})

hl.layer_rule({
	name = "swaync-notification-window-blur",
	match = { namespace = "swaync-notification-window" },

	blur = true,
	ignore_alpha = 0.5,
})

hl.layer_rule({
	-- Disable fade animation for vicinae only.
	name = "vicinae-no-anim",
	match = { namespace = "vicinae" },

	no_anim = true,
})

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})
