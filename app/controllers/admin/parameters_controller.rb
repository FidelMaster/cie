class Admin::ParametersController < Admin::ApplicationController
  before_action :set_admin_parameter, only: [:show, :edit, :update, :destroy]
  layout "admin/dashboard_layout"
  # GET /admin/parameters
  # GET /admin/parameters.json
  def index
    @admin_parameters = Admin::Parameter.all
  end

  # GET /admin/parameters/1
  # GET /admin/parameters/1.json
  def show
  end

  # GET /admin/parameters/new
  def new
    #if Admin::Parameter.count == 0
      @admin_parameter = Admin::Parameter.new
    #else
    #  respond_to do |format|
    #    format.html { redirect_to admin_parameters_url, notice: 'Unicamente se permite un solo registro de parámetros.' }
    #    format.json { head :no_content }
    #  end
    #end
  end

  # GET /admin/parameters/1/edit
  def edit
  end

  # POST /admin/parameters
  # POST /admin/parameters.json
  def create
      @admin_parameter = Admin::Parameter.new(admin_parameter_params)

      respond_to do |format|
        if @admin_parameter.save
          format.html { redirect_to @admin_parameter, notice: 'Parámetros fueron creado exitosamente.' }
          format.json { render :show, status: :created, location: @admin_parameter }
        else
          format.html { render :new }
          format.json { render json: @admin_parameter.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /admin/parameters/1
  # PATCH/PUT /admin/parameters/1.json
  def update
    respond_to do |format|
      if @admin_parameter.update(admin_parameter_params)
        format.html { redirect_to @admin_parameter, notice: 'Parámetros fueron actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @admin_parameter }
      else
        format.html { render :edit }
        format.json { render json: @admin_parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/parameters/1
  # DELETE /admin/parameters/1.json
  def destroy
    @cie_resource.destroy
    respond_to do |format|
      format.html { redirect_to admin_parameters_url, notice: 'Parámetros fueron eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_parameter
      @admin_parameter = Admin::Parameter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_parameter_params
      params.require(:admin_parameter).permit(:name, :inss_hour_price, :private_hour_price, :is_eval)
    end
end
