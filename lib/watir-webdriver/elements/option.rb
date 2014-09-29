# encoding: utf-8
module Watir

  #
  # Represents an option in a select list.
  #

  class Option < HTMLElement

    #
    # Selects this option.
    #
    # @example
    #   browser.select(:id => "foo").options.first.select
    #

    def select
      wait_for_present
      @element.click
    end

    #
    # Toggles the selected state of this option.
    #
    # @example
    #   browser.select(:id => "foo").options.first.toggle
    #

    def toggle
      wait_for_present
      @element.click
    end

    #
    # Clears (i.e. toggles selected state) option.
    #
    # @example
    #   browser.select(:id => "foo").options.first.clear
    #

    def clear
      @element.click if selected?
    end

    #
    # Is this option selected?
    #
    # @return [Boolean]
    #

    def selected?
      wait_for_exists
      @element.selected?
    end

    #
    # Returns the text of option.
    #
    # Note that the text is either one of the following respectively:
    #   * label attribute
    #   * text attribute
    #   * inner element text
    #
    # @return [String]
    #

    def text
      wait_for_exists

      # A little unintuitive - we'll return the 'label' or 'text' attribute if
      # they exist, otherwise the inner text of the element

      attribute = [:label, :text].find { |a| attribute? a }

      if attribute
        @element.attribute(attribute).strip
      else
        @element.text.strip
      end
    end

  end # Option
end # Watir
