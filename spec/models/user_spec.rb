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
end
