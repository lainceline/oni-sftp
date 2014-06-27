{SelectListView} = require 'atom'

module.exports =
class OniSFTPSelectListView extends SelectListView
  initialize: ->
    super
    @addClass('overlay from-top')
    @setItems(['Add new server', 'Escambia'])
    atom.workspaceView.append(this)
    @focusFilterEditor()

  viewForItem: (item) ->
    "<li>#{item}</li>"

  confirmed: (item) ->
    console.log("#{item} was selected")
