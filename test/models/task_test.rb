require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "a completed task is complete" do
    task = Task.new
    refute(task.complete?)
    task.mark_completed
    assert(task.complete?)
  end

  test "an uncompleted task does not count toward velocity" do
    task = Task.new(size: 3)
    refute(task.part_of_velocity?)
    assert_equal(0, task.points_toward_velocity)
  end

  test "a task completed long ago does not count toward velocity" do
    task = Task.new(size: 3)
    task.mark_completed(6.months.ago)
    refute(task.part_of_velocity?)
    assert_equal(0, task.points_toward_velocity)
  end

  test "a task completed recently counts toward velocity" do
    task = Task.new(size: 3)
    task.mark_completed(1.day.ago)
    assert(task.part_of_velocity?)
    assert_equal(3, task.points_toward_velocity)
  end

  test "let's stub an object" do
    project = Project.new(name: "Project Greenlight")
    project.stubs(:name)
    assert_nil(project.name)
  end

  test "let's stub an object again" do
    project = Project.new(name: "Project Greenlight")
    project.stubs(:name).returns("Fred")
    assert_equal("Fred", project.name)
  end

  test "let's stub a class" do
    Project.stubs(:find).returns(Project.new(name: "Project Greenlight"))
    project = Project.find(1)
    assert_equal("Project Greenlight", project.name)

    # Project.any_instance.stubs(:save).returns(false)
    # stubby.stubs(:user_count).raises(Exceptions, "oops")
  end

  test "let's mock an object" do
    mock_project = Project.new(name: "Project Greenlight")
    mock_project.expects(:name).returns("Fred")
    assert_equal("Fred", mock_project.name)
  end

  test "stub with multipple returns" do
    stubby = Project.new
    stubby.stubs(:user_count).returns(1, 2)
    # stubby.stubs(:user_count).returns(1).then.returns(2)
    assert_equal(1, stubby.user_count)
    assert_equal(2, stubby.user_count)
    assert_equal(2, stubby.user_count)
  end

end
