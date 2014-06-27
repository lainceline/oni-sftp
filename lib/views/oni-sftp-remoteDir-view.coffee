{$, $$, SelectListView} = require 'atom'
fs = require 'fs'
path = require 'path'

module.exports =
  class OniRemoteDirView extends SelectListView

    initialize: (fileList) ->
      super
      @addClass 'overlay from-top'
      @setItems fileList

      atom.workspaceView.append(this)
      @focusFilterEditor()

    viewForItem: (item) ->
      $$ ->
        @li class: 'remoteFile', =>
          @span item.filename

    confirmed: (file) ->
      @cancel()
      file.func(file.filename, file.dir, file.conn)
