require 'database'

shared_examples 'it has a valid, symbolized gender' do
  it { should be_valid }
  its(:gender) { should be_a(Symbol) }
end

# User is:
#
#   t.string :name
#   t.string :gender
#   t.string :status
#   t.string :mood
describe 'Cymbalize' do
  let(:user_class) { create_user_class }
  subject { user_class }

  it { should respond_to(:symbolize) }
  it { should respond_to(:symbolize_attribute) }
  its(:instance_methods) { should include('read_symbolized_attribute') }

  context 'with symbolized gender' do
    let(:symbolize_options) { {} }
    before { user_class.symbolize :gender, symbolize_options }
    specify { subject.options_for(:gender).should be_nil }

    describe 'user instance' do
      subject { user_class.new(:gender => :robot) }
      it_behaves_like 'it has a valid, symbolized gender'

      context 'initialized with a string' do
        subject { user_class.new(:gender => 'robot') }
        it_behaves_like 'it has a valid, symbolized gender'
      end
    end

    context 'with the :in option' do
      let(:symbolize_options) { {:in => [:robot, :alien]} }
      specify { subject.options_for(:gender).should =~ [:robot, :alien] }

      describe 'user instance' do
        subject { user_class.new(:gender => gender) }

        context 'with a gender in the list' do
          let(:gender) { :robot }
          it_behaves_like 'it has a valid, symbolized gender'
        end

        context 'with a gender not in the list' do
          let(:gender) { :cowboy }
          it { should_not be_valid }
        end
      end
    end

    context 'with the :allow_blank option' do
      let(:symbolize_options) { {:in => [:robot, :alien], :allow_blank => true} }

      describe 'user instance' do
        subject { user_class.new(:gender => gender) }

        context 'with an empty string value' do
          let(:gender) { '' }
          it { should be_valid }
          its(:gender) { should be_nil }
        end

        context 'with a nil value' do
          let(:gender) { nil }
          it { should be_valid }
          its(:gender) { should be_nil }
        end
      end
    end

    context 'with the :methods option' do
      let(:symbolize_options) {{
        :in => [:robot, :alien, :cowboy],
        :methods => true
      }}

      its(:instance_methods) { should include('robot?', 'alien?') }

      describe 'robot user instance' do
        subject { user_class.new(:gender => :robot) }

        it { should respond_to(:robot?, :alien?) }
        it { should be_robot }
        it { should_not be_alien }
      end
    end

    context 'with the :scopes option' do
      let(:symbolize_options) {{
        :in => [:robot, :alien, :cowboy],
        :scopes => true
      }}

      it { should respond_to(:robot, :alien, :cowboy) }

      let(:robot_user) { user_class.create(:gender => :robot) }
      its(:robot) { should include(robot_user) }
      its(:alien) { should_not include(robot_user) }
    end
  end
end
