{$, $$, SelectListView} = require 'atom'
fs = require 'fs'
path = require 'path'

OniSetupServer = require '../models/oni-setup-server'
OniBrowseServer = require '../models/oni-browse-server'

module.exports =
class OniSftpBrowseView extends SelectListView

  initialize: ->
    super
    @addClass('overlay from-top')

    @servers = @getServerList()
    @addCommands()

    atom.workspaceView.append(this)
    @focusFilterEditor()

  getServerList: ->
    servers = []
    files = []

    configPath = path.join(process.env['HOME'], '/.config/atom-oni-sftp')
    if fs.existsSync configPath
      files = fs.readdirSync(configPath)

    for file in files
      servers.push file.substring(0, file.indexOf('.'))

    servers

  addCommands: ->
    @storeFocusedElement()

    commands = []

    #add the Add new server command
    commands.push({name: 'add-server', description: 'Add new server', func: -> OniSetupServer()})

    for server in @servers
      commands.push({name: server, description: server, func: (server) -> OniBrowseServer(server)})

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

  confirmed: (server) ->
    @cancel()
    server.func(server.name)
