import React                        from 'react'
import Fluxxor                      from 'fluxxor'
import { History, Link }            from 'react-router'
import { Table, Thead, Th, Tr, Td } from 'reactable'
import Loader                       from 'react-loader'
import $                            from 'jquery'

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
    @props.flux.actions.admin.forms.load(@props.flux.store('AuthStore').authToken) unless @state.loaded

  deleteForm: (e) ->
    e.preventDefault()
    if confirm('Are you sure you want to delete this form? This action cannot be undone.')
      @props.flux.actions.admin.form.destroy(
        authToken: @props.flux.store('AuthStore').authToken
        id: $(e.target).data('id')
      )

  render: ->
    <Loader loaded={@state.loaded}>
      <Link to={'/admin/forms/new'} className='btn'>New Form</Link>
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
              <Link to={"/admin/forms/#{form.id}"}>{form.title}</Link>
            </Td>
            <Td column='edit'>
              <Link to={"/admin/forms/#{form.id}/edit"}>Edit</Link>
            </Td>
            <Td column='delete'>
              <a href='#' data-id={form.id} onClick={@deleteForm}>Delete</a>
            </Td>
          </Tr>
        }
      </Table>
    </Loader>
