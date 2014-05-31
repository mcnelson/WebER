require 'spec_helper'

describe User do
  it 'has permission predicate methods' do
    u = User.new(permission_level: 'student')
    expect(u).to be_student

    u = User.new(permission_level: 'workstudy')
    expect(u).to be_workstudy

    u = User.new(permission_level: 'admin')
    expect(u).to be_admin
  end

  it { is_expected.to have_secure_password }

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:punet) }
    it { is_expected.to validate_uniqueness_of(:pu_student_id) }
    it { is_expected.to validate_uniqueness_of(:email) }

    it { is_expected.to validate_presence_of(:punet) }
    it { is_expected.to validate_presence_of(:pu_student_id) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:permission_level) }

    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:password_confirmation) }
    it { is_expected.to allow_value("michael@nelsonware.com").for(:email) }
    it { is_expected.to_not allow_value("michaelnelsonware.com", "asdf").for(:email) }
  end

  describe 'assocations' do
    it { is_expected.to have_many(:reservations) }
    it { is_expected.to have_many(:packages) }
  end
end
