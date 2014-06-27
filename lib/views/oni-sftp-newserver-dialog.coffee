path = require 'path'
fs = require 'fs'
OniDialog = require './oni-sftp-dialog'

module.exports =
  class NewServerDialog extends OniDialog
    constructor: (initialPath) ->
      super
        prompt: "Enter the server name"
        initialPath: initialPath
        select: false
        iconClass: 'icon-file-add'

    onConfirm: (relativePath) ->
      console.log relativePath
      @close()
