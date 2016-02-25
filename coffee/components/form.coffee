import React       from 'react'
import MaskedInput from 'react-input-mask'
import Mailcheck   from 'mailcheck'
import QRCode      from 'qrcode.react'
import $           from 'jquery'
import _           from 'lodash'

module.exports = React.createClass
  displayName: 'Form'

  contextTypes:
    router: React.PropTypes.func

  getInitialState: ->
    {
      view: 'FORM'
      phoneRequired: false
      suggestion: {}
      showSuggestion: false
      fields: []
      form: false
      string: ''
    }

  viewForm: ->
    @state.view is 'FORM'

  viewTicket: ->
    @state.view is 'TICKET'

  canTextChange: (e) ->
    @setState(phoneRequired: $(e.target).is(':checked'))

  checkEmail: (e) ->
    Mailcheck.run(
      email: $(e.target).val()
      suggested: (suggestion) =>
        @setState(suggestion: suggestion, showSuggestion: true)
      empty: =>
        @setState(suggestion: {}, showSuggestion: false)
    )

  acceptSuggestion: (e) ->
    return if $(e.target).is('.x')
    $('#email').val @state.suggestion.full
    @setState(suggestion: {}, showSuggestion: false)

  declineSuggestion: ->
    @setState(suggestion: {}, showSuggestion: false)

  componentWillMount: ->
    if @props.params.slug
      ref = FirebaseUtils.fb("forms/#{@props.params.slug.toLowerCase()}")
      @bindAsObject(ref, 'form')
      @bindAsArray(ref.child('fields'), 'fields')

  makeId: (string) ->
    string = string.toLowerCase()
    string = string.replace(/[^a-zA-Z ]/g, "")
    string = string.split(" ").join("")

  submitForm: (e) ->
    e.preventDefault()

    data =
      first_name: $('#first_name').val()
      last_name: $('#last_name').val()
      phone: $('#phone').val()
      email: $('#email').val()
      zip: $('#zip').val()
      canText: $('#canText').prop('checked')

    # If this is a custom form, save the response to Firebase.
    if @props.params.slug
      formData = _.cloneDeep(data)

      for field in @state.fields
        if field.type is 'checkbox'
          formData[field.title] = $("##{@makeId(field.title)}").prop('checked')
        else
          formData[field.title] = $("##{@makeId(field.title)}").val()

      FirebaseUtils.fb("forms/#{@props.params.slug.toLowerCase()}/responses").push(formData)

    # Stringify basic fields.
    allFields = [
      'first_name'
      'last_name'
      'phone'
      'email'
      'zip'
      'canText'
    ]
    string = JSON.stringify(allFields.map( (key) -> data[key] )).slice(1, -1)
    @setState(view: 'TICKET', string: string)

    canvas = $('canvas')[0]

    # Set save button to download the canvas
    $('#save').attr('href', canvas.toDataURL())

    # Set print button to print the canvas
    $('#print').on 'click', ->
      windowContent = "<html><body><img src='#{canvas.toDataURL()}' style='width: 400px;' /></body></html>"
      printWin = window.open()
      printWin.document.open()
      printWin.document.write(windowContent)
      printWin.document.close()
      printWin.focus()
      printWin.print()
      printWin.close()

  render: ->
    <div>
      <section className={"form #{'hidden' unless @viewForm()}"}>
        <h2>
          Event Registration
        </h2>
        <hr />
        {if @state.form['.value'] is null
          <p className={'no-form'}>No form exists at this URL -- please double-check spelling or contact event staff.</p>
        else if @props.params.slug && @state.form is false
          <div />
        else
          <form className={'signup'}>
            <input className={'first_name'} type={'text'} id={'first_name'} placeholder={'First Name'} required={true} />
            <input className={'last_name'} type={'text'} id={'last_name'} placeholder={'Last Name'} required={true} />
            <MaskedInput className={'phone'} type={'tel'} id={'phone'} placeholder={'Cell Phone #'} mask={'(999) 999-9999'} required={@state.phoneRequired} />
            <input className={'email'} type={'email'} id={'email'} placeholder={'Email Address'} required={true} onBlur={@checkEmail} />
            { if @state.showSuggestion
              <div className={'email-suggestion'} onClick={@acceptSuggestion}>
                <span className={'suggestion'}>
                  Did you mean {@state.suggestion.address}@<strong>{@state.suggestion.domain}</strong>?
                </span>
                <span className={'x'} onClick={@declineSuggestion}>X</span>
              </div>
            }

            <MaskedInput className={'zip'} id={'zip'} name={'zip'} placeholder={'Zip Code'} type={'tel'} required={true} mask={'99999'} />

            {for field, idx in @state.fields when field.type is 'text'
              <input className={'custom_field'} key={idx} type={'text'} id={@makeId(field.title)} placeholder={field.title} required={true} />
            }

            <div className={'checkboxgroup'}>
              <input type={'checkbox'} id={'canText'} onChange={@canTextChange} />
              <label htmlFor={'canText'} className={'checkbox-label'}>
                Receive text msgs from Bernie 2016
                <span className={'disclaimer'}><br />Msg and data rates may apply</span>
              </label>
            </div>

            {for field, idx in @state.fields when field.type is 'checkbox'
              <div className={'checkboxgroup'} key={idx}>
                <input type={'checkbox'} id={@makeId(field.title)} />
                <label className={'checkbox-label'}>
                  {field.title}
                </label>
              </div>
            }

            <a href={'#'} className={'btn'} onClick={@submitForm}>Sign Up</a>
          </form>
        }
      </section>

      <section className={"ticket #{'hidden' unless @viewTicket()}"}>
        <h2>Bernie 2016</h2>
        <QRCode value={@state.string} size={300} fgColor={'#147FD7'} />
        <h2>Event Ticket</h2>
        <a id={'print'} className={'btn'}>
          Print
        </a><br />
        <a id={'save'} download={'ticket.png'} className={'btn'}>
          Save
        </a>
      </section>
    </div>
