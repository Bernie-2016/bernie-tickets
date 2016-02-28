import Fluxxor   from 'fluxxor'
import constants from 'constants'

module.exports = Fluxxor.createStore
  initialize: (options) ->
    @id = null
    @title = null
    @fields = []
    @loaded = false
    @error = false

    @bindActions(constants.ADMIN.FORM.LOAD, @onLoadForm)
    @bindActions(constants.ADMIN.FORM.LOAD_SUCCESS, @onLoadFormSuccess)
    @bindActions(constants.ADMIN.FORM.LOAD_FAILURE, @onLoadFormFailure)

  onLoadForm: ->
    @loaded = false
    @emit('change')

  onLoadFormSuccess: (response) ->
    if response is null
      @error = true
    else
      @id = response.id
      @title = response.title
      @fields = response.questions
      @loaded = true
    @emit('change')

  onLoadFormFailure: ->
    @error = true
    @emit('change')
