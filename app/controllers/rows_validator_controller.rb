class RowsValidatorController < ApplicationController
  def initialize(row)
    @row = row.with_indifferent_access
    @errors = []
  end

  def validates
    if @row['name'].blank?
      @errors << 'El nombre no puede estar vacio'
    end
    if !/^[a-zA-Z0-9]+([- ][a-zA-Z0-9]+)*$/.match(@row['name'])
      @errors << 'El nombre no cumple con el formato requerido'
    end
    if !@row['dob'].match(/\d{4}-\d{2}-\d{2}/)
      @errors << 'El formato de la fecha no es valido'
    end
    if !@row['telephone'].match(/\+\d{2}[- ]\d{3}[- ]\d{3}[- ]\d{2}[- ]\d{2}/)
      @errors << 'El formato de telefono no es valido'
    end
    if !/^[^@]+@[^@]+\.[a-zA-Z]{2,}$/.match(@row['email'])
      @errors << 'El formato de email no es valido'
    end
    card = cardvalidate @row['credit_card']
    if card == 'false'
      @errors << 'La tarjeta no corresponde con ninguna de las franquicias validas'
      #@errors << 'Tarjeta de credito ' + @row['credit_card'].to_s + ' Tiene una longitud de '+ @row['credit_card'].delete(' ').length.to_s + ' y empieza por '+ @row['credit_card'][0..3]
    end
    
  end

  def cardvalidate(card)
    card = card.to_s
    if (card[0..1] == '34' || card[0..1] == '37') && card.delete(' ').length ==15
      return 'American Express'
    elsif ('3528'..'3589').to_a.include?(card[0..3]) && (card.delete(' ').length >= 16 && card.delete(' ').length <= 19)
      return 'JCB'
    elsif (('2221'..'2720').include?(card[0..3]) || ('51'..'55').include?(card[0..1])) && card.delete(' ').length == 16
      return 'Mastercard'
    elsif card[0] == '4' && card.delete(' ').length == 16
      return 'Visa'
    elsif (card.length >= 14 && card.delete(' ').length <= 19)
      return 'Diners'
    else
      return 'false'
    end
  end

  def errors
    @errors.join('. ')
  end
end
