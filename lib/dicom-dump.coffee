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
    dicomDumpViewState: @dicomDumpView.serialize()

  dcmtkPathChanged: ->
    @dcmtkInstallPath = atom.config.get "dicom-dump.dcmtkInstallPath"

  dcmdumpView: ->
    filePath = atom.workspace.getActiveTextEditor().getPath()

    dcmtkPath = atom.config.get "dicom-dump.dcmtkInstallPath"
    command = path.join(dcmtkPath,'dcmdump')
    args = [filePath]

    atom.workspace.open(filePath+'.dcmdump')
    .then (editor) =>
      @editor = editor.copy()
      @editor.setText('')
      stdout = (output) => @showDump output
      exit = (code) -> console.log("dcmdump exited with #{code}")
      process = new BufferedProcess({command, args, stdout, exit})

    return

  showDump: (buffer) ->
    oldText = @editor.getText()
    @editor.setText(oldText+buffer)

  dsrdumpView: ->
    filePath = atom.workspace.getActiveTextEditor().getPath()

    dcmtkPath = atom.config.get "dicom-dump.dcmtkInstallPath"
    command = path.join(dcmtkPath,'dsrdump')
    args = [filePath]

    atom.workspace.open(filePath+'.dsrdump')
    .then (editor) =>
      @editor = editor.copy()
      @editor.setText('')
      stdout = (output) => @showDump output
      exit = (code) -> console.log("dsrdump exited with #{code}")
      process = new BufferedProcess({command, args, stdout, exit})

    return
