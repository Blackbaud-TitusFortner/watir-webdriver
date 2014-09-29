module Watir
  module UserEditable

    #
    # Clear the element, the type in the given value.
    #
    # @param [String, Symbol] *args
    #

    def set(*args)
      wait_for_present
      assert_writable

      @element.clear
      @element.send_keys(*args)
    end
    alias_method :value=, :set

    #
    # Appends the given value to the text in the text field.
    #
    # @param [String, Symbol] *args
    #

    def append(*args)
      wait_for_present
      assert_writable

      @element.send_keys(*args)
    end
    alias_method :<<, :append

    #
    # Clears the text field.
    #

    def clear
      wait_for_present
      @element.clear
    end

  end # UserEditable
end # Watir
