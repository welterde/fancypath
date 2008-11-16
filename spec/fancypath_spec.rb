require File.dirname(__FILE__) + '/spec_helper'

describe Fancypath do

before do
  TMP_DIR.rmtree if TMP_DIR.exist?
  TMP_DIR.mkpath
  @file = TMP_DIR.to_path/'testfile'
  @dir = TMP_DIR.to_path/'testdir'
end
after  { TMP_DIR.rmtree }

describe '#/' do
  
  it('returns Fancypath') { (@dir/'somefile').class.should == Fancypath }  
  it('joins paths') { (@dir/'somefile').to_s.should =~ /\/somefile$/ }
  
end

describe '#touch', 'file does not exist' do
  
  it('returns self') { @file.touch.should == @file }  
  it('returns a Fancypath') { @file.touch.should be_instance_of(Fancypath) }
  it('creates file') { @file.touch.should be_file }
  
end

describe '#create', 'dir does not exist' do
  
  it('returns self') { @dir.create.should == @dir }
  it('returns a Fancypath') { @dir.create.should be_instance_of(Fancypath) }
  it('creates directory') { @dir.create.should be_directory }
  
end

describe '#remove' do
  
  it('returns self') { @file.remove.should == @file }
  it('returns a Fancypath') { @file.remove.should be_instance_of(Fancypath) }
  it('removes file') { @file.touch.remove.should_not exist }  
  it('removes directory') { @dir.create.remove.should_not exist }
  
end

describe '#write' do
  
  it('returns self') { @file.write('').should == @file }
  it('returns a Fancypath') { @file.write('').should be_instance_of(Fancypath) }
  it('writes contents to file') { @file.write('test').read.should == 'test' }
  
end

end #/Fancypath

describe "String#to_path" do
  
  it('returns a Fancypath') { 'test'.to_path.should be_instance_of(Fancypath) }
  
end

describe "Pathname#to_path" do
  
  it('returns a Fancypath') { Fancypath.new('/').to_path.should be_instance_of(Fancypath) }
  
end