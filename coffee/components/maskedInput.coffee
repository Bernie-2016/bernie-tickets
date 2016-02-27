import React            from 'react'
import classNames       from 'classnames'
import { Input }        from 'react-bootstrap'
import MaskedInputField from 'react-maskedinput'

class MaskedInput extends Input
  renderInput: ->
    className = @isCheckboxOrRadio() || @isFile() ? '' : 'form-control'
    return (
      <MaskedInputField {...this.props} className={classNames(@props.className, className)} ref='input' key='input' />
    )

module.exports = MaskedInput
