DepositDanaOnlineView = require './deposit-dana-online-view'
{CompositeDisposable} = require 'atom'

module.exports = DepositDanaOnline =
  depositDanaOnlineView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @depositDanaOnlineView = new DepositDanaOnlineView(state.depositDanaOnlineViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @depositDanaOnlineView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'deposit-dana-online:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @depositDanaOnlineView.destroy()

  serialize: ->
    depositDanaOnlineViewState: @depositDanaOnlineView.serialize()

  toggle: ->
    console.log 'DepositDanaOnline was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
