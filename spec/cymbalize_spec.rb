require 'database'

describe 'ActiveRecord::Base' do
  subject { ActiveRecord::Base }

  it { should respond_to(:symbolize) }
  it { should respond_to(:symbolize_attribute) }
  its(:instance_methods) { should include('read_symbolized_attribute') }
end
