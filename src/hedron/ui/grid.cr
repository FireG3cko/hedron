require "../bindings.cr"
require "../control.cr"
require "../struct/align.cr"
require "../struct/side.cr"
require "../widget/*"

module Hedron
  struct GridCell
    property size : Tuple(Int32, Int32)
    property expand_x : Bool
    property align_x : Align
    property expand_y : Bool
    property align_y : Align

    def initialize(@size, @expand_x, @align_x, @expand_y, @align_y); end
  end

  class Grid < Widget
    include Control

    @this : UI::Grid*

    def initialize
      @this = UI.new_grid
    end

    def insert(widget : Widget, next_to : Widget, side : Side, cell_info : GridCell)
      UI.grid_insert_at(
        to_unsafe,
        ui_control(widget.control.to_unsafe),
        ui_control(next_to.control.to_unsafe),
        side,
        cell_info.size[0], cell_info.size[1],
        to_int(cell_info.expand_x), cell_info.align_x.value,
        to_int(cell_info.expand_y), cell_info.align_y.value
      )
    end

    def padded : Bool
      return to_bool(UI.grid_padded(to_unsafe))
    end

    def padded=(is_padded : Bool)
      return UI.grid_set_padded(to_unsafe, to_int(is_padded))
    end

    def push(widget : Widget, coords : Tuple(Int32, Int32), cell_info : GridCell)
      UI.grid_append(
        to_unsafe,
        ui_control(widget.control.to_unsafe),
        coords[0], coords[1],
        cell_info.size[0], cell_info.size[1],
        to_int(cell_info.expand_x), cell_info.align_x.value,
        to_int(cell_info.expand_y), cell_info.align_y.value
      )
    end

    def to_unsafe
      return @this
    end
  end
end