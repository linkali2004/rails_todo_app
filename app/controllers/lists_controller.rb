class ListsController < ApplicationController
  before_action :set_list, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /lists or /lists.json
  def index
    @lists = List.where(user_id:current_user.id)
    msg = ""
  end

  # GET /lists/1 or /lists/1.json
  def show
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit

  end

  # POST /lists or /lists.json
  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    respond_to do |format|
      if @list.save
        format.turbo_stream do 
          # turbo_stream.prepend("lists", partial: "lists/list", locals: { list: @list })
         render turbo_stream:turbo_stream.prepend("flash_messages", partial: "layouts/show_flash_message", locals: { msg: "Item Created Successfully" })
        end
      else
        format.turbo_stream { render turbo_stream: turbo_stream.prepend(@list, partial:"lists/form",locals:{list:@list})}
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
  end
end
end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.turbo_stream do 
        render turbo_stream:turbo_stream.prepend("flash_messages", partial: "layouts/show_flash_message", locals: { msg: "Item Updated Successfully" })
        end
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@list, partial:"lists/list",locals:{list:@list})}
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    @list.destroy!

    respond_to do |format|
       render turbo_stream:turbo_stream.prepend("flash_messages", partial: "layouts/show_flash_message", locals: { msg: "Item Deleted" })
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(:title)
    end
end
