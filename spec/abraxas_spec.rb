require "spec_helper"

describe Abraxas do
  before(:each) do
    Abraxas.stub!(:statsd_send) { |msg| msg.size }
    Abraxas.stub!(:carbon_send) { |msg| msg.size }
  end

  context "with a value argument" do
    it "sends counter data" do
      Abraxas.answer_of("the.question", 42).should eq("the.question:42|c")
      Abraxas.how_many("lights", 4).should eq("lights:4|c")
      Abraxas.call_me("number", 2).should eq("number:2|c")
      Abraxas.sample("the.merchandise", 1, 0.1).should eq("the.merchandise:1|c|@0.1")
    end
  end

  context "with a block argument" do
    it "sends timer data" do
      (Abraxas.double("double") { sleep 0.234 }).should match(/^double:\d{3}\|ms$/)
      (Abraxas.toil("and.trouble") { sleep 0.050 }).should match(/^and.trouble:\d{2}\|ms$/)
      (Abraxas.all_lost("to.prayers.to_prayers") { sleep 0.019 }).should match(/^to.prayers.to_prayers:\d{2}\|ms$/)
      (Abraxas.the_dark_backward("abysm.of.time") { sleep 0.023 }).should match(/^abysm.of.time:\d{2}\|ms$/)
      (Abraxas.i_prithee("be.my.god") { sleep 0.083 }).should match(/^be.my.god:\d{2,3}\|ms$/)
    end
  end

  context "with invalid arguments" do
    it "raises NoMethodError" do
      expect {Abraxas.invalid()}.to raise_error(NoMethodError)
      expect {Abraxas.badstat(24)}.to raise_error(NoMethodError)
      expect {Abraxas.alsobad("56")}.to raise_error(NoMethodError)
      expect {Abraxas.unfortunate(:shoggoth)}.to raise_error(NoMethodError)
      expect {Abraxas.uncool(:muon, 23)}.to raise_error(NoMethodError)
      expect {Abraxas.shameful("kuroi", "neko")}.to raise_error(NoMethodError)
      expect {Abraxas.insane(21, 12)}.to raise_error(NoMethodError)
      expect {Abraxas.what?(:shiroi, :inu)}.to raise_error(NoMethodError)
    end
  end
end
