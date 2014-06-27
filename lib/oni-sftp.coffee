OniSftpBrowseView = require './views/oni-sftp-browse-view'

OniSetupServer = require './models/oni-setup-server'
OniDownload = require './models/oni-sftp-download'
OniUpload = require './models/oni-sftp-upload'

module.exports =

  activate: (state) ->
    atom.workspaceView.command 'oni-sftp:menu', -> new OniSftpBrowseView()
    atom.workspaceView.command 'oni-sftp:setup', -> OniSetupServer()
    atom.workspaceView.command 'oni-sftp:download', -> OniDownload()
    atom.workspaceView.command 'oni-sftp:upload', -> OniUpload()

  deactivate: ->

  serialize: ->
