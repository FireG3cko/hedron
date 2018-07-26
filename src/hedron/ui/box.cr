require "../bindings.cr"
require "../control.cr"
require "../widget/*"

module Hedron
  abstract class Box < MultipleContainer
    include Control

    def delete_at(index : Int32)
      UI.box_delete(to_unsafe, index)
    end

    def padded : Bool
      return to_bool(UI.box_padded(to_unsafe))
    end

    def padded=(is_padded : Bool)
      UI.box_set_padded(to_unsafe, to_int(is_padded))
    end

    def push(child : Widget)
      child.parent = self
      UI.box_append(to_unsafe, ui_control(child.control.to_unsafe), to_int(child.control.stretchy))
    end

    def push(*children : Widget)
      children.each { |child| push(child) }
    end

    def set_property(key : String, value : Any)
      gen_properties({"stretchy" => Bool, "padded" => Bool})
    end
  end

  class VerticalBox < Box
    @this : UI::Box*

    def initialize
      @this = UI.new_vertical_box
    end

    def self.init_markup
      return self.new
    end

    def to_unsafe
      return @this
    end
  end

  class HorizontalBox < Box
    @this : UI::Box*

    def initialize
      @this = UI.new_horizontal_box
    end

    def self.init_markup
      return self.new
    end

    def to_unsafe
      return @this
    end
  end
end
