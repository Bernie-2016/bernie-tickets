import React                            from 'react'
import { Row, Col, Input, ButtonInput } from 'react-bootstrap'
import $                                from 'jquery'
import randomId                         from 'random-id'

module.exports = React.createClass
  displayName: 'AdminFormForm'

  setFieldTitle: (e) ->
    index = $(e.target).data('index')
    fields = @props.fields
    fields[index].title = e.target.value
    @props.set(fields: fields)

  setFieldType: (e) ->
    index = $(e.target).data('index')
    fields = @props.fields
    fields[index].type = e.target.value
    @props.set(fields: fields)

  addField: (e) ->
    e.preventDefault()
    fields = @props.fields
    fields.push { id: randomId(), title: '', type: 'text' }
    @props.set(fields: fields)

  removeField: (e) ->
    e.preventDefault()
    index = $(e.target).data('index')
    fields = @props.fields
    fields.splice(index, 1)
    @props.set(fields: fields)

  render: ->
    <form onSubmit={@props.submit}>
      
      <Input type='text' label='Title' placeholder='Form title' value={@props.title} onChange={ (e) => @props.set(title: e.target.value) } />
      <Input type='text' label='Slug' placeholder='Form slug' value={@props.slug} onChange={ (e) => @props.set(slug: e.target.value) } addonBefore='https://bernietickets.com/' />
      <label className='control-label'>Custom Fields</label>
      {for field, index in @props.fields
        <Row key={field.id}>
          <Col xs={5}>
            <Input type='text' label='Field title' placeholder='Field title' value={field.title} data-index={index} onChange={@setFieldTitle} />
          </Col>
          <Col xs={5}>
            <Input type='select' label='Field type' data-index={index} onChange={@setFieldType}>
              <option value='text'>Text</option>
              <option value='checkbox'>Checkbox</option>
            </Input>
          </Col>
          <Col xs={2}>
            <label className='control-label' />
            <ButtonInput className='remove' data-index={index} onClick={@removeField} value='Remove' />
          </Col>
        </Row>
      }
      <ButtonInput onClick={@addField} value='Add Field' />
      <ButtonInput bsStyle='primary' type='submit' value={@props.submitText} />
    </form>
