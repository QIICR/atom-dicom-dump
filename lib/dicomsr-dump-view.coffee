{$, ScrollView} = require 'atom-space-pen-views'
{Disposable} = require 'atom'
{BufferedProcess} = require 'atom'
path = require 'path'
fs = require 'fs-plus'

module.exports =
class DicomSRDumpView extends ScrollView
  @content: ->
    @div class: 'dicomsr-view padded pane-item', tabindex: -1, =>
      @div class: 'dicomsr-dump', outlet: 'dicomsrDump'

  initialize: ({@filePath}) =>
    super

  attached: ->
    @dicomFile(@filePath)

    @dicomsrDump.css
      'font-family': atom.config.get('editor.fontFamily')
      'font-size': atom.config.get('editor.fontSize')

  dicomFile: (filePath) ->
    dcmtkPath = atom.config.get "dicom-dump.dcmtkInstallPath"
    command = dcmtkPath+'/dsrdump'
    args = [filePath]
    prompt = "dsrdump of "+filePath
    @dicomsrDump.append "<header>#{prompt}</header>"

    @dicomsrDump.append "<div>"
    stdout = (output) => @showDump output
    exit = (code) -> console.log("dsrdump exited with #{code}")
    process = new BufferedProcess({command, args, stdout, exit})

    @dicomsrDump.append "</div>"

  showDump: (buffer) =>
    buffer = buffer.replace /\ /g, "&nbsp;"
    buffer = buffer.replace />/g, "&gt;"
    buffer = buffer.replace /</g, "&lt;"
    buffer = buffer.replace /\n/g, "<br>"
    @dicomsrDump.append buffer

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  getPath: -> @filePath

  getURI: -> @filePath

  getTitle: -> "dsrdump #{path.basename(@getPath())}"
