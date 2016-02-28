import Fluxxor   from 'fluxxor'
import _         from 'lodash'
import constants from 'constants/all'

module.exports = Fluxxor.createStore
  initialize: (options) ->
    @forms = []
    @loaded = false
    @error = false
    @createdId = null
    @updatedId = null
    @destroyedId = null

    @bindActions(constants.ADMIN.FORMS.LOAD, @onLoadForms)
    @bindActions(constants.ADMIN.FORMS.LOAD_SUCCESS, @onLoadFormsSuccess)
    @bindActions(constants.ADMIN.FORMS.LOAD_FAILURE, @onFailure)
    @bindActions(constants.ADMIN.FORMS.CREATE, @onCreateForm)
    @bindActions(constants.ADMIN.FORMS.CREATE_SUCCESS, @onCreateFormSuccess)
    @bindActions(constants.ADMIN.FORMS.CREATE_FAILURE, @onFailure)
    @bindActions(constants.ADMIN.FORM.UPDATE, @onUpdateForm)
    @bindActions(constants.ADMIN.FORM.UPDATE_SUCCESS, @onUpdateFormSuccess)
    @bindActions(constants.ADMIN.FORM.UPDATE_FAILURE, @onFailure)
    @bindActions(constants.ADMIN.FORM.DESTROY, @onDestroyForm)
    @bindActions(constants.ADMIN.FORM.DESTROY_SUCCESS, @onDestroyFormSuccess)
    @bindActions(constants.ADMIN.FORM.DESTROY_FAILURE, @onFailure)

  onFailure: (response) ->
    @error = true
    @emit('change')

  onLoadForms: ->
    @loaded = false
    @emit('change')

  onLoadFormsSuccess: (response) ->
    @forms = response || []
    @loaded = true
    @emit('change')

  onCreateForm: ->
    @loaded = false
    @emit('change')

  onCreateFormSuccess: (response) ->
    @forms.push(response)
    @loaded = true
    @createdId = response.id
    @emit('change')
    @createdId = false

  onUpdateForm: ->
    @loaded = false
    @emit('change')

  onUpdateFormSuccess: (response) ->
    index = _.findIndex(@forms, id: response.id)
    @forms.splice(index, 1, response)
    @loaded = true
    @updatedId = response.id
    @emit('change')
    @updatedId = false

  onDestroyForm: (id) ->
    @destroyedId = id
    @emit('change')
    
  onDestroyFormSuccess: ->
    @forms = _.reject(@forms, id: @destroyedId)
    @destroyedId = null
    @emit('change')
