fs = require 'fs'
path = require 'path'
{Workspace, Editor, File, $} = require 'atom'
events = require 'events'

defaultFileContent = require './oni-default-file-content'

oniSetupServer = () ->
  #create a new config file
  #check if config directory exists first, create if not
  configPath = path.join process.env['HOME'], '.config', 'atom-oni-sftp'

  fs.exists configPath, (exists) ->
    if not exists
      fs.mkdir configPath, '0777', () ->
        console.log('made dir')

  newServerFile = path.join configPath, 'server.json'

  #fs.writeFile newServerFile, defaultFileContent()

  theEditor = atom.workspace.open newServerFile

  theEditor.then (result) ->
    result.setText(defaultFileContent())
    pane = atom.workspace.getActivePane()

    buffer = pane.getActiveItem().getBuffer()

    buffer.on 'will-be-saved', =>
      pane.saveActiveItemAs()

module.exports = oniSetupServer
