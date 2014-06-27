{Workspace} = require('atom')
Connection = require('ssh2')
fs   = require('fs')
path = require('path')

oniSftpOpen = (filename, isDir, conn) ->
  tmpPath = '/tmp/atom-oni-sftp'
  console.log isDir
  conn.sftp (err, sftp) ->
    #console.log isDir
    if isDir
      sftp.readdir filename, (err, list) ->
        for file in list
          console.log file.filename
    else
      sftp.fastGet filename, path.join(tmpPath, filename), (err) ->
        atom.workspace.open path.join(tmpPath, filename)

module.exports = oniSftpOpen
