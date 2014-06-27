Connection = require('ssh2')
fs   = require('fs')
path = require('path')

oniBrowseServer = (server) ->
  #read the json config for this server
  configFilePath = path.join process.env['HOME'], "/.config/atom-oni-sftp/#{server}.json"

  fs.readFile configFilePath, 'utf8', (err, data) ->
    data = JSON.parse(data)

    @options =
      username: data['user']
      password: data['password']
      host: data['host']
      port: data['port']
      path: data['remote_path']

    conn = new Connection()
    conn.on 'ready', () ->
      console.log 'connection: ready'
      conn.sftp (err, sftp) ->
        sftp.readdir @options['path'], (err, list) ->
          fileList = []
          for file in list
            fileList.push file.filename

          console.log fileList.join('\n')
          conn.end()
    .connect(
      host: @options['host']
      port: @options['port']
      username: @options['username']
      password: @options['password']
    )

    'hello'

module.exports = oniBrowseServer
