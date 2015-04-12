class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.all
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
  end

  # GET /lists/new
  def new
    @list=List.new
    @lists=List.all
  end
  def move_up
    @list=List.find(params[:id])
    @foo=@list
    @list.decrement_position
    redirect_to list_path(foo_param: @foo), notice: 'Todo List was successfully moved up.'
  end

  def move_down

    @list=List.find(params[:id])
    @foo=@list
    @list.increment_position
    redirect_to list_path(foo_param: @foo), notice: 'Todo List was successfully moved down.'
  end




  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    @list=List.new(params.require(:list).permit(:name))
    @lists=List.all

    respond_to do |format|
      if @list.save
        format.html { redirect_to new_list_path, notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def move

    if ["move_lower", "move_higher", "move_to_top", "move_to_bottom"].include?(params[:method]) and params[:list_id] =~ /^\d+$/
      #if the incoming params contain any of these methods and a numeric book_id,
      #let's find the book with that id and send it the acts_as_list specific method
      #that rode in with the params from whatever link was clicked on
      List.find(params[:list_id]).send(params[:method])
    end
    #after we're done updating the position (which gets done in the background
    #thanks to acts_as_list, let's just go back to the list page,
    #refreshing the page basically because I didn't say this was an RJS
    #tutorial, maybe next time
    redirect_to :action => :list
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:name)
    end


end
