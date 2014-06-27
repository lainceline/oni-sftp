{WorkspaceView} = require 'atom'
OniSftp = require '../lib/oni-sftp'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "OniSftp", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('oni-sftp')

  describe "when the oni-sftp:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.oni-sftp')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'oni-sftp:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.oni-sftp')).toExist()
        atom.workspaceView.trigger 'oni-sftp:toggle'
        expect(atom.workspaceView.find('.oni-sftp')).not.toExist()
