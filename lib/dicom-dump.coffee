DicomDumpView = require './dicom-dump-view'
{CompositeDisposable} = require 'atom'

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
    @dicomDumpView = new DicomDumpView(state.dicomDumpViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @dicomDumpView.getElement(), visible: false)
    @dcmtkInstallPath = atom.config.get "dicom-view.dcmtkInstallPath"

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # DCMTK Path setting
    @subscriptions.add atom.config.observe "dicom-dump.dcmtkInstallPath", =>
      @dcmtkPathChanged()

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'dicom-dump:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @dicomDumpView.destroy()

  serialize: ->
    dicomDumpViewState: @dicomDumpView.serialize()

  toggle: ->
    console.log 'DicomDump was toggled!'
    console.log atom.config.get "dicom-dump.dcmtkInstallPath"

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

  dcmtkPathChanged: ->
    console.log 'DCMTK path has changed!'
    @dcmtkInstallPath = atom.config.get "dicom-view.dcmtkInstallPath"
