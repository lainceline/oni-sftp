path = require 'path'
fs = require 'fs'
OniDialog = require './oni-sftp-dialog'
{Workspace} = require 'atom'

defaultFileContent = require '../models/oni-default-file-content'

module.exports =
  class NewServerDialog extends OniDialog
    constructor: (initialPath) ->
      super
        prompt: "Enter the server name"
        initialPath: ''
        select: false
        iconClass: 'icon-file-add'

    onConfirm: (relativePath) ->
      configPath = path.join process.env['HOME'], '.config', 'atom-oni-sftp'

      fs.exists configPath, (exists) ->
        if not exists
          fs.mkdir configPath, '0777', () ->

      filePath = path.join configPath, relativePath+'.json'

      theEditor = atom.workspace.open filePath
      theEditor.then (result) ->
        result.setText(defaultFileContent())
      @close()
