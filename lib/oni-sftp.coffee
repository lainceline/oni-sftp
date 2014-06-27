OniSFTPSelectListView = require './oni-sftp-view'

module.exports =
  oniSftpView: null

  activate: (state) ->
    #@oniSftpView = new OniSFTPSelectListView(state.oniSftpViewState)
    atom.workspaceView.command "oni-sftp:menu", => @menu()

  menu: ->
    new OniSFTPSelectListView()

  deactivate: ->
    @oniSftpView.destroy()

  serialize: ->
    oniSftpViewState: @oniSftpView.serialize()
