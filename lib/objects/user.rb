require 'csv'

class User

  USER_ATTRIBUTES = %w(primary_id first_name middle_name last_name gender user_group campus_code status address_line_1 address_line_2 address_city address_state_province address_postal_code address_country email phone)

  attr_reader *USER_ATTRIBUTES

  def initialize(csv_row)

    details = CSV.parse(csv_row)

    # details should be an array of size 16

    USER_ATTRIBUTES.each_with_index do |key, i|

      self.send("#{key}=".to_sym, details[0][i])

    end

  end

  def primary_id=(v)
    @primary_id = v
  end
  
  def first_name=(v)
    @first_name = v
  end
  
  def middle_name=(v)
    @middle_name = v
  end
  
  def last_name=(v)
    @last_name = v
  end
  
  def gender=(v)
    @gender = v
  end
  
  def user_group=(v)
    @user_group = v
  end
  
  def campus_code=(v)
    @campus_code = v
  end
  
  def status=(v)
    @status = v
  end
  
  def address_line_1=(v)
    @address_line_1 = v
  end
  
  def address_line_2=(v)
    @address_line_2 = v
  end
  
  def address_city=(v)
    @address_city = v
  end
  
  def address_state_province=(v)
    @address_state_province = v
  end
  
  def address_postal_code=(v)
    @address_postal_code = v
  end
  
  def address_country=(v)
    @address_country = v
  end
  
  def email=(v)
    @email = v
  end
  
  def phone=(v)
    @phone = v
  end

end