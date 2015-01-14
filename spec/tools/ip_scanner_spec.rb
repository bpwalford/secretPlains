require 'rails_helper'

describe IpScanner do

  before do
    ip = {
      country_code: '0',
      country_name: 'Reserved',
      longitude: '',
      region_name: 'RD',
      city: 'city',
    }

    @ip = IpScanner.new(ip).build_ip
  end

  context 'unknown:' do
    it 'returns unknown for Reserved' do
      expect(@ip[:country_name]).to eq('unknown')
    end

    it 'returns unknown for 0' do
      expect(@ip[:country_code]).to eq('unknown')
    end

    it 'returns unknow for RD' do
      expect(@ip[:region_name]).to eq('unknown')
    end

    it 'returns unknow for empty string' do
      expect(@ip[:longitude]).to eq('unknown')
    end
  end

  context 'known:' do
    it 'returns the value if its valid' do
      expect(@ip[:city]).to eq('city')
    end
  end

end
