{$, $$, SelectListView} = require 'atom'

OniSetupServer = require '../models/oni-setup-server'

module.exports =
class OniSftpBrowseView extends SelectListView

  initialize: ->
    super
    @addClass('overlay from-top')

    @addCommands()

    atom.workspaceView.append(this)
    @focusFilterEditor()

  addCommands: ->
    @storeFocusedElement()

    commands = []

    #add the Add new server command
    commands.push({name: 'add-server', description: 'Add new server', func: -> OniSetupServer()})

    #now we will want to add all the stored sftp servers to the commands list
    #We'll be storing these servers in json files

    @setItems(commands)

  populateList: ->
    return unless @items?

    #do stuff with this later
    filterQuery = @getFilterQuery()

    filteredItems = @items

    @list.empty()
    if filteredItems.length
      @setError(null)
      for i in [0...Math.min(filteredItems.length, @maxItems)]
        item = filteredItems[i].original ? filteredItems[i]
        itemView = $(@viewForItem(item, filteredItems[i].string ? null))
        itemView.data('select-list-item', item)
        @list.append(itemView)

      @selectItemView(@list.find('li:first'))
    else
      @setError(@getEmptyMessage(@items.length, filteredItems.length))

  viewForItem: ({name, description}, matchedStr) ->
    $$ ->
      @li class: 'command', 'data-command-name': name, =>
        if matchedStr? then @raw(matchedStr) else @span description

  confirmed: ({func}) ->
    @cancel()
    func()
