require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  
  def setup
    @group = Group.new(name: "All Clients")
  end

  test "should be valid" do
    assert @group.valid?
  end

  test "name should be present" do
    @group.name = "     "
    assert_not @group.valid?
  end

  test "name should not be too long" do
    @group.name = "a" * 101
    assert_not @group.valid?
  end

  test "name should be unique" do
    duplicate_group = @group.dup
    duplicate_group.name = @group.name.upcase
    @group.save
    assert_not duplicate_group.valid?
  end

end
