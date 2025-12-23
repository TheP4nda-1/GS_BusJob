fx_version 'cerulean'
game 'gta5'

name "GS_BusJob"
description "d"
author "TheP4nda"
version "0.0.1"
lua54({"yes"})

shared_script '@es_extended/imports.lua'

files {
	'html/*.*'
}
ui_page 'html/index.html'

shared_scripts {
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}

