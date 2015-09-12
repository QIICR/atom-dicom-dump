{$, ScrollView} = require 'atom-space-pen-views'
{Disposable} = require 'atom'
{BufferedProcess} = require 'atom'
path = require 'path'
fs = require 'fs-plus'
entities = null

module.exports =
class DicomDumpView extends ScrollView
  @content: ->
    @div class: 'dicom-view padded pane-item', tabindex: -1, =>
      @div class: 'dicom-dump', outlet: 'dicomDump'

  initialize: ({@filePath}) =>
    super

  attached: ->
    entities ?= require 'entities'
    @dicomFile(@filePath)

    @dicomDump.css
      'font-family': atom.config.get('editor.fontFamily')
      'font-size': atom.config.get('editor.fontSize')

  dicomFile: (filePath) ->
    dcmtkPath = atom.config.get "dicom-dump.dcmtkInstallPath"
    command = dcmtkPath+'/dcmdump'
    args = [filePath]
    prompt = "dcmdump of "+filePath
    @dicomDump.append "<header>#{prompt}</header>"

    @dicomDump.append "<div>"
    stdout = (output) => @showDump output
    exit = (code) -> console.log("dcmdump exited with #{code}")
    process = new BufferedProcess({command, args, stdout, exit})

    @dicomDump.append "</div>"

  showDump: (buffer) =>
    buffer = buffer.replace /\n/g, "<br>"
    buffer = buffer.replace /\ /g, "&nbsp;"
    @dicomDump.append buffer

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  getPath: -> @filePath

  getURI: -> @filePath

  getTitle: -> "dcmdump #{path.basename(@getPath())}"
