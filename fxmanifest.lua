fx_version 'adamant'
game 'gta5'

name 'ARP /ME,DO,TRY'
description '/me, /do & /try commands'
author 'hoaaiww'
version 'v1.2'
url 'https://discord.io/AntiQRolePlay'

client_script {
    'config.lua',
    'client/client.lua'
}

server_script {
    'config.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua'
}
