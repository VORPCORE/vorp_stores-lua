fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
author 'outsider'

client_scripts 'client/*.lua'
server_scripts 'server/*.lua'

shared_scripts {
    'config.lua',
    'locale.lua',
    'languages/*.lua'
}

--dont touch
version '1.0'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_stores-lua'
