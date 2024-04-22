class NgosController < ApplicationController
  before_action :set_ngo, only: %i[ show edit update destroy ]

  # GET /ngos or /ngos.json
  def index
    @ngos = Ngo.all
  end

  # GET /ngos/1 or /ngos/1.json
  def show
  end

  # GET /ngos/new
  def new
    @ngo = Ngo.new
  end

  # GET /ngos/1/edit
  def edit
  end

  # POST /ngos or /ngos.json
  def create
    @ngo = Ngo.new(ngo_params)

    respond_to do |format|
      if @ngo.save
        format.html { redirect_to ngo_url(@ngo), notice: "Ngo was successfully created." }
        format.json { render :show, status: :created, location: @ngo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ngo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ngos/1 or /ngos/1.json
  def update
    respond_to do |format|
      if @ngo.update(ngo_params)
        format.html { redirect_to ngo_url(@ngo), notice: "Ngo was successfully updated." }
        format.json { render :show, status: :ok, location: @ngo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ngo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ngos/1 or /ngos/1.json
  def destroy
    @ngo.destroy!

    respond_to do |format|
      format.html { redirect_to ngos_url, notice: "Ngo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ngo
      @ngo = Ngo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ngo_params
      params.fetch(:ngo, {})
    end
end
