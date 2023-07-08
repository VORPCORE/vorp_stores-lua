fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
author 'VORP @outsider31000'
lua54 'yes'

client_script 'client/client.lua'
server_script 'server/server.lua'

shared_scripts {
    'config.lua',
    'shared/buyitemsCFG.lua',
    'shared/sellitemsCFG.lua',
    'shared/language.lua',
    'images/*.png'
}

dependencies {
    'menuapi',
    'vorp_core', -- download from the vorp github
    'vorp_utils', -- download from the vorp github
    'vorp_inventory', -- download from the vorp github
}


--dont
--touch

version '2.0'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_stores-lua'
