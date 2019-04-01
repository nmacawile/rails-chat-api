require 'rails_helper'

RSpec.describe Join, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:joinable) }
end
