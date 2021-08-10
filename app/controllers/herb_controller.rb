class HerbController < ApplicationController

  def index
    @herbs = Herb.all
  end

  def show
    @herb = Herb.find(params[:id])
  end

  def new
    @herb = Herb.new
  end

  def create
    @herb = Herb.create(herb_params)
    if @herb.valid?
      redirect_to herbs_path
    else
      redirect_to new_herb_path
    end
  end

  # Anything below private can only be called inside the scope of this class
  private
  # Strong params:
  def herb_params
    params.require(:herb).permit(:name, :watered)
  end

end
