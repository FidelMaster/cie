class CustomExceptions::SpecialException < StandardError
  def http_status
    403
  end

  def code
    'not_allowed'
  end

  def message
    "Error al guardar el registro"
  end

  def to_hash
    {
      message: message,
      code: code
    }
  end
end