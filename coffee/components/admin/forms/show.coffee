import React             from 'react'
import Fluxxor           from 'fluxxor'
import { History, Link } from 'react-router'
import { Row, Col }      from 'react-bootstrap'
import Loader            from 'react-loader'
import _                 from 'lodash'

module.exports = React.createClass
  displayName: 'AdminForm'

  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin('AuthStore', 'FormsStore'), History]

  getStateFromFlux: ->
    store = @props.flux.store('FormsStore')
    form = _.find(store.forms, id: parseInt(@props.params.id)) || {}

    {
      title: form.title
      slug: form.slug
      fields: form.questions || []
      loaded: store.loaded
      error: store.error
      destroyedId: store.destroyedId
    }

  deleteForm: (e) ->
    e.preventDefault()
    if confirm('Are you sure you want to delete this form? This action cannot be undone.')
      @props.flux.actions.admin.form.destroy(
        authToken: @props.flux.store('AuthStore').authToken
        id: parseInt(@props.params.id)
      )

  componentDidMount: ->
    @props.flux.actions.admin.forms.load(@props.flux.store('AuthStore').authToken) unless @state.loaded

  componentDidUpdate: ->
    @history.pushState(null, '/admin/forms') if @state.destroyedId

  render: ->
    <Loader loaded={@state.loaded}>
      <h1>{@state.title}</h1>
      
      {if _.isEmpty(@state.fields)
        <h4>No custom fields</h4>
      else
        <h4>Fields:</h4>
      }
      {for field in @state.fields
        <div key={field.id}>
          <p>
            <strong>Title:</strong> {field.title}
          </p>
          <p>
            <strong>Type:</strong> {field.type}
          </p>
          <hr />
        </div>
      }
      <Link to={"/admin/forms/#{@props.params.id}/edit"} className='btn'>
        Edit
      </Link>
      <a href='#' className='btn' onClick={@deleteForm}>
        Delete
      </a>
    </Loader>
