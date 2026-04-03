fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "html/index.html"

files {
	"html/**/*",
	"custom.lua"
}

shared_script {
	"adapter/config.shared.lua"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"adapter/locale.client.lua",
	"adapter/animations.client.lua",
	"adapter/core.client.lua",

	"custom.lua",

}

server_scripts {
	"@vrp/lib/utils.lua",
	"updater/_version.lua",
	"updater/_server.lua",
	"adapter/core.server.lua",

}

data_file "DLC_ITYP_REQUEST" "stream/hype_folia_flags"
