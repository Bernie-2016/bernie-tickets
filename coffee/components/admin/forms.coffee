import React                        from 'react'
import Fluxxor                      from 'fluxxor'
import { History }                  from 'react-router'
import { Table, Thead, Th, Tr, Td } from 'reactable'
import Loader                       from 'react-loader'

module.exports = React.createClass
  displayName: 'AdminForms'

  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin('AuthStore', 'FormsStore'), History]

  getStateFromFlux: ->
    store = @props.flux.store('FormsStore')

    {
      forms: store.forms
      loaded: store.loaded
      error: store.error
    }

  componentDidMount: ->
    @props.flux.actions.admin.forms.load(@props.flux.store('AuthStore').authToken)

  render: ->
    <Loader loaded={@state.loaded}>
      <Table className='table table-striped' filterable={['title']} noDataText='No forms.'>
        <Thead>
          <Th column='title'>
            <strong>Title</strong>
          </Th>
          <Th column='edit'>
            <strong>Edit</strong>
          </Th>
          <Th column='delete'>
            <strong>Delete</strong>
          </Th>
        </Thead>
        {for form in @state.forms
          <Tr key={form.id}>
            <Td column='title'>
              {form.title}
            </Td>
            <Td column='edit'>
              <a href='#'>Edit</a>
            </Td>
            <Td column='delete'>
              <a href='#'>Delete</a>
            </Td>
          </Tr>
        }
      </Table>
    </Loader>
