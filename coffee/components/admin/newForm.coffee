import React             from 'react'
import Fluxxor           from 'fluxxor'
import { History, Link } from 'react-router'
import Form              from 'components/admin/formForm'

module.exports = React.createClass
  displayName: 'AdminNewForm'

  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin('AuthStore', 'FormsStore'), History]

  getStateFromFlux: ->
    store = @props.flux.store('FormsStore')

    {
      title: ''
      slug: ''
      fields: []
      loaded: store.loaded
      error: store.error
    }

  set: (payload) ->
    @setState(payload)

  submit: ->
    @props.flux.actions.admin.form.create(
      authToken: @props.flux.store('AuthStore').authToken
      data:
        title: @state.title
        slug: @state.slug
        fields: @state.fields
    )

  render: ->
    <Form title={@state.title} slug={@state.slug} fields={@state.fields} set={@set} submit={@submit} /> 
