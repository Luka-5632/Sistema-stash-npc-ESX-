fx_version 'cerulean'

games {'gta5' }

author 'Luka'


version '1.0'

lua54 'on'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'Shared/Config.lua',
    'Shared/*.lua'
}

client_scripts {
    '@es_extended/imports.lua',
    'Client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'Server/*.lua'
}
