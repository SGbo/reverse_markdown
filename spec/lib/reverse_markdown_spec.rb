require 'spec_helper'

describe ReverseMarkdown do
  let(:input)    { File.read('spec/assets/minimum.html') }
  let(:document) { Nokogiri::HTML(input) }

  it "parses nokogiri documents" do
    expect { ReverseMarkdown.convert(document) }.not_to raise_error
  end

  it "parses nokogiri elements" do
    expect { ReverseMarkdown.convert(document.root) }.not_to raise_error
  end

  it "parses string input" do
    expect { ReverseMarkdown.convert(input) }.not_to raise_error
  end

  it "behaves in a sane way when root element is nil" do
    expect(ReverseMarkdown.convert(nil)).to eq ''
  end

  describe '#config' do
    it 'stores a given configuration option' do
      ReverseMarkdown.config.github_flavored = true
      expect(ReverseMarkdown.config.github_flavored).to eq true
    end

    it 'can be used as a block configurator as well' do
      ReverseMarkdown.config do |config|
        expect(config.github_flavored).to eq false
        config.github_flavored = true
      end
      expect(ReverseMarkdown.config.github_flavored).to eq true
    end
  end
end
