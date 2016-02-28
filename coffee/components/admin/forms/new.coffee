import React             from 'react'
import Fluxxor           from 'fluxxor'
import { History, Link } from 'react-router'
import { Row, Col }      from 'react-bootstrap'
import Form              from 'components/admin/forms/form'

module.exports = React.createClass
  displayName: 'AdminNewForm'

  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin('AuthStore', 'FormsStore'), History]

  getStateFromFlux: ->
    store = @props.flux.store('FormsStore')

    {
      title: ''
      slug: ''
      fields: []
      error: store.error
      createdId: store.createdId
    }

  set: (payload) ->
    @setState(payload)

  submit: (e) ->
    e.preventDefault()
    @props.flux.actions.admin.form.create(
      authToken: @props.flux.store('AuthStore').authToken
      data:
        form:
          title: @state.title
          slug: @state.slug
          questions_attributes: @state.fields
    )

  componentDidUpdate: ->
    @history.pushState(null, "/admin/forms/#{@state.createdId}") if @state.createdId

  render: ->
    <Row>
      <Col md={6} xs={12}>
        <h1>New Form</h1>
        <Form title={@state.title} slug={@state.slug} fields={@state.fields} set={@set} submit={@submit} submitText='Create Form' /> 
      </Col>
    </Row>
