import Fluxxor   from 'fluxxor'
import _         from 'lodash'
import constants from 'constants'

module.exports = Fluxxor.createStore
  initialize: (options) ->
    @events = []
    @loaded = false
    @error = false
    @createdId = null
    @updatedId = null
    @destroyedId = null

    @bindActions(constants.ADMIN.EVENTS.LOAD, @onLoadEvents)
    @bindActions(constants.ADMIN.EVENTS.LOAD_SUCCESS, @onLoadEventsSuccess)
    @bindActions(constants.ADMIN.EVENTS.LOAD_FAILURE, @onFailure)
    # @bindActions(constants.ADMIN.EVENTS.CREATE, @onCreateForm)
    # @bindActions(constants.ADMIN.EVENTS.CREATE_SUCCESS, @onCreateEventsuccess)
    # @bindActions(constants.ADMIN.EVENTS.CREATE_FAILURE, @onFailure)
    # @bindActions(constants.ADMIN.FORM.UPDATE, @onUpdateForm)
    # @bindActions(constants.ADMIN.FORM.UPDATE_SUCCESS, @onUpdateEventsuccess)
    # @bindActions(constants.ADMIN.FORM.UPDATE_FAILURE, @onFailure)
    # @bindActions(constants.ADMIN.FORM.DESTROY, @onDestroyForm)
    # @bindActions(constants.ADMIN.FORM.DESTROY_SUCCESS, @onDestroyEventsuccess)
    # @bindActions(constants.ADMIN.FORM.DESTROY_FAILURE, @onFailure)

  onFailure: (response) ->
    @error = true
    @emit('change')

  onLoadEvents: ->
    @loaded = false
    @emit('change')

  onLoadEventsSuccess: (response) ->
    @events = response || []
    @loaded = true
    @emit('change')

  # onCreateForm: ->
  #   @loaded = false
  #   @emit('change')

  # onCreateFormSuccess: (response) ->
  #   @forms.push(response)
  #   @loaded = true
  #   @createdId = response.id
  #   @emit('change')
  #   @createdId = false

  # onUpdateForm: ->
  #   @loaded = false
  #   @emit('change')

  # onUpdateFormSuccess: (response) ->
  #   index = _.findIndex(@forms, id: response.id)
  #   @forms.splice(index, 1, response)
  #   @loaded = true
  #   @updatedId = response.id
  #   @emit('change')
  #   @updatedId = false

  # onDestroyForm: (id) ->
  #   @destroyedId = id
  #   @emit('change')
    
  # onDestroyFormSuccess: ->
  #   @forms = _.reject(@forms, id: @destroyedId)
  #   @destroyedId = null
  #   @emit('change')
