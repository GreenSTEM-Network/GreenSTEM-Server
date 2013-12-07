require 'spec_helper'

describe Site do

  it { should have_many :nodes }
  it { should have_many :node_readings }
end
