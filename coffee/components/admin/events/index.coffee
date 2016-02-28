import React                        from 'react'
import Fluxxor                      from 'fluxxor'
import { History, Link }            from 'react-router'
import { Table, Thead, Th, Tr, Td } from 'reactable'
import Loader                       from 'react-loader'
import $                            from 'jquery'
import _                            from 'lodash'
import moment                       from 'moment'
import numeral                      from 'numeral'

module.exports = React.createClass
  displayName: 'AdminEvents'

  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin('AuthStore', 'EventsStore'), History]

  getStateFromFlux: ->
    store = @props.flux.store('EventsStore')

    {
      events: store.events
      loaded: store.loaded
      error: store.error
    }

  componentDidMount: ->
    @props.flux.actions.admin.events.load(@props.flux.store('AuthStore').authToken) unless @state.loaded

  render: ->
    campaign = _.endsWith(@props.location.pathname, 'campaign')
    if campaign
      events = _.reject(@state.events, date: null)
    else
      events = _.filter(@state.events, date: null)

    <Loader loaded={@state.loaded}>
      <Link to={'/admin/events/new'} className='btn'>New Event</Link>
      <Table className='table table-striped' filterable={['name']} noDataText='No events.'>
        {if campaign
          <Thead>
            <Th column='date'>
              <strong>Date</strong>
            </Th>
            <Th column='name'>
              <strong>Name</strong>
            </Th>
            <Th column='donationsCount'>
              <strong>Donations - Count</strong>
            </Th>
            <Th column='donationsTotal'>
              <strong>Donations - Total</strong>
            </Th>
            <Th column='signups'>
              <strong>Signups</strong>
            </Th>
            <Th column='tag'>
              <strong>Tag</strong>
            </Th>
          </Thead>
        else
          <Thead>
            <Th column='name'>
              <strong>Name</strong>
            </Th>
            <Th column='donationsCount'>
              <strong>Donations - Count</strong>
            </Th>
            <Th column='donationsTotal'>
              <strong>Donations - Total</strong>
            </Th>
            <Th column='signups'>
              <strong>Signups</strong>
            </Th>
          </Thead>
        }
        {for evt in events
          <Tr key={evt.id}>
            {if campaign
              <Td column='date'>
                {moment(evt.date).format('MM/DD/YYYY') if evt.date}
              </Td>
            }
            <Td column='name'>
              <Link to={"/admin/events/#{evt.id}"}>{evt.name}</Link>
            </Td>
            <Td column='donationsCount'>
              {evt.donations_count}
            </Td>
            <Td column='donationsTotal'>
              {numeral(evt.donations_amount).format('$0,0.00')}
            </Td>
            <Td column='signups'>
              {evt.signups_count}
            </Td>
            {if campaign
              <Td column='tag'>
                {evt.tag}
              </Td>
            }
          </Tr>
        }
      </Table>
    </Loader>
