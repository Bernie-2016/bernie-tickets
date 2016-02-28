import React                  from 'react'
import { Input, ButtonInput } from 'react-bootstrap'
import DatePicker             from 'react-bootstrap-datetimepicker'

module.exports = React.createClass
  displayName: 'AdminEventForm'

  render: ->
    <form onSubmit={@props.submit}>
      <Input type='text' label='Name' placeholder='Event name' value={@props.name} onChange={ (e) => @props.set(name: e.target.value) } />
      <label className='control-label'>Date</label>
      <DatePicker inputFormat='MM/DD/YYYY' value={@props.date} onChange={ (value) => @props.set(date: value) } />
      <br />
      <Input type='text' label='Tag' placeholder='Event tag' value={@props.tag} onChange={ (e) => @props.set(tag: e.target.value) } />
      <Input type='checkbox' label='Event is current' checked={@props.checked} onChange={ (e) => @setState(current: $(e.target).is(':checked')) } />
      
      <ButtonInput bsStyle='primary' type='submit' value={@props.submitText} />
    </form>
