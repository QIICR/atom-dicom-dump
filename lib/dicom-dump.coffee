fs = require 'fs-plus'

DicomDumpView = null
DicomSRDumpView = null
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
    #@dicomDumpView = new DicomDumpView(state.dicomDumpViewState)
    #@modalPanel = atom.workspace.addModalPanel(item: @dicomDumpView.getElement(), visible: false)
    @dcmtkInstallPath = atom.config.get "dicom-dump.dcmtkInstallPath"

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # DCMTK Path setting
    @subscriptions.add atom.config.observe "dicom-dump.dcmtkInstallPath", =>
      @dcmtkPathChanged()

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
      'dicom-dump:toggledcm': => @createView()
    @subscriptions.add atom.commands.add 'atom-workspace',
      'dicom-dump:togglesr': => @createSRView()

    # following hex package
    @DCMopenerDisposable = atom.workspace.addOpener(openDCMURI)
    @SRopenerDisposable = atom.workspace.addOpener(openSRURI)

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

  createView: ->
    console.log "createView called"
    paneItem = atom.workspace.getActivePaneItem()
    filePath = paneItem.getPath()

    if paneItem and fs.isFileSync(filePath)
      console.log 'Opening file path:'+filePath
      atom.workspace.open('dicom-dump://'+filePath)
    else
      console.warn "File (#{filePath}) does not exists"

  createSRView: ->
    console.log 'createSRView called'
    paneItem = atom.workspace.getActivePaneItem()
    filePath = paneItem.getPath()

    if paneItem and fs.isFileSync(filePath)
      console.log 'Opening file path:'+filePath
      atom.workspace.open('dicomsr-dump://'+filePath)
    else
      console.warn "File (#{filePath}) does not exists"

openDCMURI = (uriToOpen) ->
  console.log 'openURI with'+uriToOpen.substr(0,12)
  return unless uriToOpen.substr(0, 10) is 'dicom-dump'
  pathname = uriToOpen.replace 'dicom-dump://', ''

  DicomDumpView ?= require './dicom-dump-view'
  console.log "Type is DCM"
  new DicomDumpView(filePath: pathname)

openSRURI = (uriToOpen) ->
  console.log 'openURI with'+uriToOpen.substr(0,12)
  return unless uriToOpen.substr(0, 12) is 'dicomsr-dump'
  pathname = uriToOpen.replace 'dicomsr-dump://', ''

  console.log "Type is SR"
  DicomSRDumpView ?= require './dicomsr-dump-view'
  new DicomSRDumpView(filePath: pathname)
