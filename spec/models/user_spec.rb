require 'spec_helper'

describe User do
  describe'#student?' do
    subject { User.new(permission_level: 0) }
    specify {
      expect(subject).to be_student
      expect(subject).to_not be_workstudy
      expect(subject).to_not be_admin
    }
  end

  describe '#workstudy?' do
    subject { User.new(permission_level: 1) }

    specify {
      expect(subject).to be_student
      expect(subject).to be_workstudy
      expect(subject).to_not be_admin
    }
  end

  describe '#admin?' do
    subject { User.new(permission_level: 2) }

    specify {
      expect(subject).to be_student
      expect(subject).to be_workstudy
      expect(subject).to be_admin
    }
  end

  describe '#permission_name' do
    context "student" do
      subject { User.new(permission_level: 0) }
      specify { expect(subject.permission_name).to eql("student") }
    end

    context "workstudy" do
      subject { User.new(permission_level: 1) }
      specify { expect(subject.permission_name).to eql("workstudy") }
    end

    context "admin" do
      subject { User.new(permission_level: 2) }
      specify { expect(subject.permission_name).to eql("admin") }
    end

    context "unknown" do
      subject { User.new(permission_level: 9001) }
      specify { expect(subject.permission_name).to eql("(unk.)") }
    end
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
