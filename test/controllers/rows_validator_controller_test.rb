require 'test_helper'

class RowsValidatorControllerTest < ActionDispatch::IntegrationTest
  test "should get initialize" do
    get rows_validator_initialize_url
    assert_response :success
  end

  test "should get validate" do
    get rows_validator_validate_url
    assert_response :success
  end

  test "should get errors" do
    get rows_validator_errors_url
    assert_response :success
  end

end
