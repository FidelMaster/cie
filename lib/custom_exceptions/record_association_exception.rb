class CustomExceptions::RecordAssociationException < StandardError
  def http_status
    403
  end

  def code
    'not_allowed'
  end

  def message
    "Documentos o campos asociados al registro no permiten que sea eliminado correctamente"
  end

  def to_hash
    {
      message: message,
      code: code
    }
  end
end

