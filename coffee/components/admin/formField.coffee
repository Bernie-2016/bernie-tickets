import React from 'react'

module.exports = React.createClass
  displayName: 'AdminFormField'

  contextTypes:
    router: React.PropTypes.func

  getInitialState: ->
    {
      field: null
      nameError: false
    }

  update: (field, e) ->
    if e.target.value && e.target.value.trim().length isnt 0
      @firebaseRefs['field'].child(field).set(e.target.value)
      @setState(nameError: false)
    else
      @setState(nameError: true)

  remove: (field, e) ->
    e.preventDefault()
    @firebaseRefs['field'].remove()

  componentWillMount: ->
    ref = FirebaseUtils.fb("forms/#{@props.slug.toLowerCase()}/fields/#{@props.id}")
    @bindAsObject(ref, 'field')

  render: ->
    <div className={'field'}>
      <input type={'text'} defaultValue={@state.field.title if @state.field} className={'error' if @state.nameError} onChange={@update.bind(null, 'title')} />
      <select value={@state.field.type if @state.field} onChange={@update.bind(null, 'type')}>
        <option value={'text'}>Text</option>
        <option value={'checkbox'}>Checkbox</option>
      </select>
      <a href={'#'} onClick={@remove.bind(null, @state.field['.key'] if @state.field)}>X</a>
    </div>
