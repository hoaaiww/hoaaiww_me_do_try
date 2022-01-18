fx_version 'cerulean'
game 'gta5'

name 'ARP /ME, DO & TRY'
description '/me, /do & /try commands'
author 'hoaaiww'
version '1.6'

client_scripts {
    'config.lua',
    'client/client.lua'
}

server_scripts {
    'config.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua'
}
