require 'spec_helper'

describe Node do
  
  it { should belong_to :site }
  it { should have_many :readings }
 
end
