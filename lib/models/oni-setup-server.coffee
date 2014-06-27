fs = require 'fs'
createPane = require 'atom-pane'
path = require 'path'
{Workspace, Editor, File, $} = require 'atom'
events = require 'events'
AddDialog = null

defaultFileContent = require './oni-default-file-content'

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
  dialog.on 'file-created', (event, createdPath) ->
    console.log(event)
  dialog.attach()
  #theEditor = atom.workspace.open newServerFile

  #theEditor.then (result) ->
  #  result.setText(defaultFileContent())
  #  console.log result
  #  pane = atom.workspace.getActivePane()
  #  console.log pane
  #  buffer = pane.getActiveItem().getBuffer()
  #  console.log buffer
    #buffer.on 'will-be-saved', =>
    #  pane.saveActiveItemAs()
    #  newUri = buffer.file.path
    #  pane.destroyItem(result)
    #  atom.workspace.open newUri

module.exports = oniSetupServer
