fs = require 'fs'
path = require 'path'
#process = require 'process'
defaultFileContent = require './oni-default-file-content'

oniSetupServer = () ->
  console.log('onisetupserver')
  #create a new config file
  #check if config directory exists first, create if not
  configPath = path.join process.env['HOME'], '.config', 'atom-oni-sftp'

  fs.exists configPath, (exists) ->
    if not exists
      fs.mkdir configPath, '0777', () ->
        console.log('made dir')

  fs.writeFile path.join(configPath, 'server.json'), defaultFileContent()

  #@todo - add opening the file right after creating it

module.exports = oniSetupServer
