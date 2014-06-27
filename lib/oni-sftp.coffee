OniSftpBrowseView = require './views/oni-sftp-browse-view'

module.exports =

  activate: (state) ->
    atom.workspaceView.command "oni-sftp:menu", => @menu()

  menu: ->
    new OniSftpBrowseView()

  deactivate: ->

  serialize: ->
