module Selectize

  def fill_in_selectized(id, params={})
    find("##{id} + .selectize-control input").set params[:with]
    find('.option', text: /#{params[:with]}/).click
  end

end

World(Selectize)