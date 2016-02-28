import Fluxxor   from 'fluxxor'
import _         from 'lodash'
import constants from 'constants/all'

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
    @bindActions(constants.ADMIN.EVENTS.CREATE, @onCreateEvent)
    @bindActions(constants.ADMIN.EVENTS.CREATE_SUCCESS, @onCreateEventSuccess)
    @bindActions(constants.ADMIN.EVENTS.CREATE_FAILURE, @onFailure)
    @bindActions(constants.ADMIN.EVENTS.UPDATE, @onUpdateEvent)
    @bindActions(constants.ADMIN.EVENTS.UPDATE_SUCCESS, @onUpdateEventSuccess)
    @bindActions(constants.ADMIN.EVENTS.UPDATE_FAILURE, @onFailure)
    @bindActions(constants.ADMIN.EVENTS.DESTROY, @onDestroyEvent)
    @bindActions(constants.ADMIN.EVENTS.DESTROY_SUCCESS, @onDestroyEventSuccess)
    @bindActions(constants.ADMIN.EVENTS.DESTROY_FAILURE, @onFailure)

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

  onCreateEvent: ->
    @loaded = false
    @emit('change')

  onCreateEventSuccess: (response) ->
    @events.push(response)
    @loaded = true
    @createdId = response.id
    @emit('change')
    @createdId = false

  onUpdateEvent: ->
    @loaded = false
    @emit('change')

  onUpdateEventSuccess: (response) ->
    index = _.findIndex(@events, id: response.id)
    @events.splice(index, 1, response)
    @loaded = true
    @updatedId = response.id
    @emit('change')
    @updatedId = false

  onDestroyEvent: (id) ->
    @destroyedId = id
    @emit('change')
    
  onDestroyEventSuccess: ->
    @events = _.reject(@events, id: @destroyedId)
    @destroyedId = null
    @emit('change')
