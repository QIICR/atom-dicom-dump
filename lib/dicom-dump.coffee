path = require 'path'

DicomDumpView = null
DicomSRDumpView = null
{CompositeDisposable} = require 'atom'
{BufferedProcess} = require 'atom'

module.exports = DicomDump =
  dicomDumpView: null
  modalPanel: null
  subscriptions: null
  dcmtkPath: null

  config:

    dcmtkInstallPath:
      title: 'Path to DCMTK installation'
      description: 'This should point to the location where dcmdump lives'
      type: 'string'
      default: '/usr/bin'
      order: 1

    dcmdumpFlags:
      title: 'dcmdump command line flags'
      description: 'These flags will be passed to dcmdump (no quotes!)'
      type: 'string'
      default: ''
      order: 2

    dsrdumpFlags:
      title: 'dsrdump command line flags'
      description: 'These flags will be passed to dsrdump (no quotes!)'
      type: 'string'
      default: ''
      order: 3

  activate: (state) ->
    #@modalPanel = atom.workspace.addModalPanel(item: @dicomDumpView.getElement(), visible: false)
    @dcmtkInstallPath = atom.config.get "dicom-dump.dcmtkInstallPath"

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # DCMTK Path setting
    @subscriptions.add atom.config.observe "dicom-dump.dcmtkInstallPath", =>
      @dcmtkPathChanged()

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
      'dicom-dump:toggledcm': => @dcmdumpView()
    @subscriptions.add atom.commands.add 'atom-workspace',
      'dicom-dump:togglesr': => @dsrdumpView()

    @editor = null

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @dicomDumpView.destroy()
    @DCMopenerDisposable.dispose()
    @SRopenerDisposable.dispose()

  serialize: ->
    # dicomDumpViewState: @dicomDumpView.serialize()

  dcmtkPathChanged: ->
    @dcmtkInstallPath = atom.config.get "dicom-dump.dcmtkInstallPath"

  dcmdumpView: ->
    filePath = atom.workspace.getActiveTextEditor().getPath()
    flags = atom.config.get "dicom-dump.dcmdumpFlags"
    flags = flags.split " "

    dcmtkPath = atom.config.get "dicom-dump.dcmtkInstallPath"
    command = path.join(dcmtkPath,'dcmdump')
    command += '.exe' if process.platform == 'win32' | process.platform == 'win64'
    args = flags.concat filePath

    atom.workspace.open(filePath+'.dcmdump')
    .then (editor) =>
      @editor = editor.copy()
      @editor.setText('')
      stdout = (output) => @showDump output
      exit = (code) -> console.log("dcmdump exited with #{code}")
      process = new BufferedProcess({command, args, stdout, exit})

    return

  showDump: (buffer) ->
    @editor.setCursorBufferPosition([Infinity, Infinity])
    @editor.insertText(buffer)

  dsrdumpView: ->
    filePath = atom.workspace.getActiveTextEditor().getPath()
    flags = atom.config.get "dicom-dump.dsrdumpFlags"
    flags = flags.split " "

    dcmtkPath = atom.config.get "dicom-dump.dcmtkInstallPath"
    command = path.join(dcmtkPath,'dsrdump')
    command += '.exe' if process.platform == 'win32' | process.platform == 'win64'
    args = flags.concat filePath

    atom.workspace.open(filePath+'.dsrdump')
    .then (editor) =>
      @editor = editor.copy()
      @editor.setText('')
      stdout = (output) => @showDump output
      exit = (code) -> console.log("dsrdump exited with #{code}")
      process = new BufferedProcess({command, args, stdout, exit})

    return
