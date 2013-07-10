require 'spec_helper'

describe User do
 
	before { @user=User.new }

	subject { @user }

	it { should respond_to(:email) }
	it { should respond_to(:encrypted_password) }
	it { should respond_to(:reset_password_token) }

end
