class IpScanner

  attr_reader :ip

  def initialize(ip)
    @ip = ip
  end

  def build_ip
    built_ip = {}

    ip.each do |key, value|
      built_ip[key] = scan_value(value)
    end

    built_ip
  end

  private

  def scan_value(value)
    return 'unknown' if value == '' || value == 'Reserved' || value == 'RD' || value == '0'
    value
  end

end
