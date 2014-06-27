defaultFileContent = () ->
  '{\n
      \t"type": "sftp",\n
      \t"host": "example.com",\n
      \t"user": "username",\n
      \t"password": "password",\n
      \t"port": "22",\n
      \t"remote_path": "/example/path",\n
      \t"ssh_key_file": "~/.ssh/id_rsa"\n
    }'

module.exports = defaultFileContent
