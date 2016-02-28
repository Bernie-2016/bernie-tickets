import React             from 'react'
import Fluxxor           from 'fluxxor'
import { History, Link } from 'react-router'
import { Row, Col }      from 'react-bootstrap'
import Loader            from 'react-loader'
import _                 from 'lodash'
import moment            from 'moment'

module.exports = React.createClass
  displayName: 'AdminEvent'

  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin('AuthStore', 'EventsStore'), History]

  getStateFromFlux: ->
    store = @props.flux.store('EventsStore')
    evt = _.find(store.events, id: parseInt(@props.params.id)) || {}

    {
      name: evt.name
      date: if evt.date then moment(evt.date) else null
      current: evt.current
      tag: evt.tag
      loaded: store.loaded
      error: store.error
      destroyedId: store.destroyedId
    }

  deleteEvent: (e) ->
    e.preventDefault()
    if confirm('Are you sure you want to delete this event? This action cannot be undone.')
      @props.flux.actions.admin.events.destroy(
        authToken: @props.flux.store('AuthStore').authToken
        id: parseInt(@props.params.id)
      )

  componentDidMount: ->
    @props.flux.actions.admin.events.load(@props.flux.store('AuthStore').authToken) unless @state.loaded

  componentDidUpdate: ->
    @history.pushState(null, '/admin/events/campaign') if @state.destroyedId

  render: ->
    <Loader loaded={@state.loaded}>
      <h1>
        {@state.name} - {@state.date.format('MM/DD/YYYY') if @state.date}
      </h1>
      <Link to={"/admin/events/#{@props.params.id}/edit"} className='btn'>
        Edit
      </Link>
      <a href='#' className='btn' onClick={@deleteEvent}>
        Delete
      </a>
    </Loader>
