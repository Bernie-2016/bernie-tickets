import Fluxxor   from 'fluxxor'
import constants from 'constants'

module.exports = Fluxxor.createStore
  initialize: (options) ->
    @forms = []
    @loaded = false
    @error = false

    @bindActions(constants.ADMIN.FORMS.LOAD, @onLoadForms)
    @bindActions(constants.ADMIN.FORMS.LOAD_SUCCESS, @onLoadFormsSuccess)
    @bindActions(constants.ADMIN.FORMS.LOAD_FAILURE, @onLoadFormsFailure)

  onLoadForms: ->
    @loaded = false
    @emit('change')

  onLoadFormsSuccess: (response) ->
    @forms = response.forms || []
    @loaded = true
    @emit('change')

  onLoadFormsFailure: ->
    @error = true
    @emit('change')
