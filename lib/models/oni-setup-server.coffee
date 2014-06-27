fs = require 'fs'
createPane = require 'atom-pane'
path = require 'path'
{Workspace, Editor, File, $} = require 'atom'
events = require 'events'
AddDialog = null

oniSetupServer = () ->
  #create a new config file
  #check if config directory exists first, create if not
  configPath = path.join process.env['HOME'], '.config', 'atom-oni-sftp'

  fs.exists configPath, (exists) ->
    if not exists
      fs.mkdir configPath, '0777', () ->

  newServerFile = path.join configPath, 'server.json'

  AddDialog ?= require '../views/oni-sftp-newserver-dialog'
  dialog = new AddDialog(configPath)
  dialog.attach()

module.exports = oniSetupServer
