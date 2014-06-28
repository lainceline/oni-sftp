{Workspace} = require('atom')
Connection = require('ssh2')
fs   = require('fs')
path = require('path')
event = require('events')

oniSftpOpen = (filename, isDir, conn) ->
  tmpPath = '/tmp/atom-oni-sftp'

  conn.sftp (err, sftp) ->

    if isDir
      sftp.readdir filename, (err, list) ->
        for file in list
          console.log file.filename
    else
      sftp.fastGet filename, path.join(tmpPath, filename), (err) ->
        theEditor = atom.workspace.open path.join(tmpPath, filename)

        #register the will-be-saved event for this new editor
        theEditor.then (result) ->
          buffer = atom.workspace.getActiveEditor().getBuffer()
          result.subscribe buffer, 'will-be-saved', () -> console.log 'hook in here'

module.exports = oniSftpOpen
