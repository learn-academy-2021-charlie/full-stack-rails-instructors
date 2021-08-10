class HerbController < ApplicationController

  def index
    @herbs = Herb.all
  end

end
