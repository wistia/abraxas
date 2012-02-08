require 'socket'

# Push simple statistics over the network to carbon or statsd.
module Abraxas
  class << self
    attr_accessor :statsd_host
    attr_accessor :statsd_port
    attr_accessor :carbon_host
    attr_accessor :carbon_port
  end

  # TODO: TCP Error handling.
  def self.carbon_send(data)
    @tcp_sock ||= TCPSocket.new(@carbon_host, @carbon_port) 
    @tcp_sock.write(data)
  end

  def self.statsd_send(data)
    @udp_sock ||= UDPSocket.new
    @udp_sock.send(data, 0, @statsd_host, @statsd_port)
  end

  # TODO: Support caching stats before transmission via TCP to reduce load.
  def self.violent_maelstrom(namespace, value, timestamp=nil)
    timestamp ||= Time.now.to_i
    data = [namespace, value, timestamp, "\n"].join(" ")
    self.carbon_send(data)
    return data
  end
  
  def self.wretched_abyss(namespace)
    start_time = Time.now
    yield
    end_time = Time.now
    duration = (end_time - start_time) * 1000.0
    timer_data = "#{namespace}:#{duration.to_i}|ms"
    self.statsd_send(timer_data)
    return timer_data
  end

  def self.howling_void(namespace, value, samplerate=nil)
    counter_data = "#{namespace}:#{value}|c"
    counter_data += "|@#{samplerate}" if samplerate
    self.statsd_send(counter_data)
    return counter_data
  end

  # NOTE: We should really have a respond_to? method, but there's basically no
  # point with such broad application of method_missing!
  def self.method_missing(method_name, *args, &block)
    if args.size == 1 and args[0].kind_of? String and block_given?
      return self.wretched_abyss(*args, &block) # "... has fallen into the wretched abyss."
    elsif args[0].kind_of? String and args[1].kind_of? Numeric
      return self.howling_void(*args) # "... was thrown into the howling void."
    elsif args.first == :raw
      return self.violent_maelstrom(*args) # "... is cast into the violent maelstrom."
    end
    super(method_name, *args, &block)
  end
end
