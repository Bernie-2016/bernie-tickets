import React        from 'react'
import Fluxxor      from 'fluxxor'
import { History }  from 'react-router'
import { Row, Col } from 'react-bootstrap'
import Form         from 'components/admin/events/form'

module.exports = React.createClass
  displayName: 'AdminNewEvent'

  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin('AuthStore', 'EventsStore'), History]

  getStateFromFlux: ->
    store = @props.flux.store('EventsStore')

    {
      name: ''
      date: null
      current: false
      tag: ''
      error: store.error
      createdId: store.createdId
    }

  set: (payload) ->
    @setState(payload)

  submit: (e) ->
    e.preventDefault()
    @props.flux.actions.admin.event.create(
      authToken: @props.flux.store('AuthStore').authToken
      data:
        event:
          name: @state.name
          date: @state.date
          is_current: @state.current
          tag: @state.tag
    )

  componentDidUpdate: ->
    @history.pushState(null, "/admin/events/#{@state.createdId}") if @state.createdId

  render: ->
    <Row>
      <Col md={6} xs={12}>
        <h1>New Event</h1>
        <Form name={@state.name} date={@state.date} current={@state.current} tag={@state.tag} set={@set} submit={@submit} submitText='Create Event' /> 
      </Col>
    </Row>
