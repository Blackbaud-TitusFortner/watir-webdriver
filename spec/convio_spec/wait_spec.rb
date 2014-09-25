# encoding: utf-8
require File.expand_path("../../watirspec/spec_helper", __FILE__)

describe Watir::Wait do

  describe "interval" do
    it "uses default interval" do
      interval_count = 0
      begin
        Wait.until(1) { interval_count+=1; false }
      rescue Watir::Wait::TimeoutError
        interval_count.should == 10
      end
    end

    it "changes default interval" do
      interval_count = 0
      begin
        Wait.retry_every(0.5).until(1) { interval_count+=1; false }
      rescue Watir::Wait::TimeoutError
        interval_count.should == 2
      end
    end

    it "restores default interval after #until" do
      begin
        Wait.retry_every(0.5).until(1) { false }
      rescue Watir::Wait::TimeoutError
      end

      interval_count = 0
      begin
        Wait.until(1) { interval_count+=1; false }
      rescue Watir::Wait::TimeoutError
        interval_count.should == 10
      end
    end

    it "restores default interval after #while" do
      begin
        Wait.retry_every(0.5).while(1) { true }
      rescue Watir::Wait::TimeoutError
      end

      interval_count = 0
      begin
        Wait.while(1) { interval_count+=1; true }
      rescue Watir::Wait::TimeoutError
        interval_count.should == 10
      end
    end

  end

end