class ItemsController < ApplicationController
  before_action :set_list
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET lists/1/items
  def index
    @items = @list.items
  end

  # GET lists/1/items/1
  def show
  end

  # GET lists/1/items/new
  def new
    @item = @list.items.build
  end

  # GET lists/1/items/1/edit
  def edit
  end

  # POST lists/1/items
  def create
    @item = @list.items.build(item_params)
    respond_to do |format|
    if @item.save
      # format.turbo_stream do
      #   render turbo_stream: turbo_stream.prepend("items", partial: "items/item", locals: { item: @item })
      #   flash.now[:notice] = "Item was successfully created."
      # end
      format.html { redirect_to "/lists/#{@item.list.id}", notice: "Item was successfully created." }
    else
      format.turbo_stream { render turbo_stream: turbo_stream.prepend(@list, partial:"items/form",locals:{list:@list})}
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @list.errors, status: :unprocessable_entity }
    end
  end
  end

  # PUT lists/1/items/1
  def update
    respond_to do |format|
    if @item.update(item_params)
      format.turbo_stream { flash.now[:notice] = "Item was successfully updated."}
    else
      format.turbo_stream { render turbo_stream: turbo_stream.prepend(@list, partial:"items/form",locals:{list:@list})}
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @list.errors, status: :unprocessable_entity }
    end
  end
  end

  # DELETE lists/1/items/1
  def destroy
    @item.destroy

    redirect_to list_items_url(@list)
    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Item was successfully removed."}
      format.html { redirect_to "/lists/#{@item.list.id}", notice: "List was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:list_id])
    end

    def set_item
      @item = @list.items.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:list_id, :name, :completed, :completed_at)
    end
end
