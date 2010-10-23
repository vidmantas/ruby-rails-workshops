module FrogsHelper

  def created_at_column(record)
    record.created_at.strftime("%Y-%m-%d")
  end

end
