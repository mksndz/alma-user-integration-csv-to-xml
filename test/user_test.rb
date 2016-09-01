require 'minitest/autorun'
require '../lib/objects/user'

class UserTest < MiniTest::Test

  FIELDS = %w(primary_id first_name middle_name last_name gender user_group campus_code status address_line_1 address_line_2 address_city address_state_province address_postal_code address_country email phone)

  def setup

    test_data_1 = "'primary_id','first_name','middle_name','last_name','gender','user_group','campus_code','status','address_line_1','address_line_2','address_city','address_state_province','address_postal_code','address_country','email','phone'"

    @user = User.new test_data_1

  end

  def test_has_primary_id
    
    assert_equal "'primary_id'", @user.primary_id
    
  end

  def test_has_first_name
    
    assert_equal "'first_name'", @user.first_name
    
  end

  def test_has_middle_name
    
    assert_equal "'middle_name'", @user.middle_name
    
  end

  def test_has_last_name
    
    assert_equal "'last_name'", @user.last_name
    
  end

  def test_has_gender
    
    assert_equal "'gender'", @user.gender
    
  end

  def test_has_user_group
    
    assert_equal "'user_group'", @user.user_group
    
  end

  def test_has_campus_code
    
    assert_equal "'campus_code'", @user.campus_code
    
  end

  def test_has_status
    
    assert_equal "'status'", @user.status
    
  end

  def test_has_address_line_1
    
    assert_equal "'address_line_1'", @user.address_line_1
    
  end

  def test_has_address_line_2
    
    assert_equal "'address_line_2'", @user.address_line_2
    
  end

  def test_has_address_city
    
    assert_equal "'address_city'", @user.address_city
    
  end

  def test_has_address_state_province
    
    assert_equal "'address_state_province'", @user.address_state_province
    
  end

  def test_has_address_country
    
    assert_equal "'address_country'", @user.address_country
    
  end

  def test_has_email
    
    assert_equal "'email'", @user.email
    
  end

  def test_has_phone
    
    assert_equal "'phone'", @user.phone
    
  end

end
