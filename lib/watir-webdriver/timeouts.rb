module Watir
  class Timeouts

    attr_reader :implicit_wait

    def initialize(control)
      @implicit_wait = 0
      @control = control
    end

    #
    # Calculates how long a Watir::Wait#until will take to execute based on combination of implicit and explicit waits
    #

    def expected_wait(explicit=nil, implicit=0)
      explicit ||= Watir.default_timeout
      if implicit == 0
        explicit
      else
        2*implicit*((explicit-1)/(2*implicit) + 1)
      end
    end

    #
    # Set the amount of time the driver should wait when searching for elements.
    #

    def implicit_wait=(seconds)
      seconds ||= 0
      @control.timeouts.implicit_wait=(seconds)
      @implicit_wait = seconds
    end

    #
    # Sets the amount of time to wait for an asynchronous script to finish
    # execution before throwing an error. If the timeout is negative, then the
    # script will be allowed to run indefinitely.
    #

    def script_timeout=(seconds)
      @control.timeouts.script_timeout=(seconds)
    end

    #
    # Sets the amount of time to wait for a page load to complete before throwing an error.
    # If the timeout is negative, page loads can be indefinite.
    #

    def page_load=(seconds)
      @control.timeouts.page_load=(seconds)
    end

  end # Timeouts
end # Watir
