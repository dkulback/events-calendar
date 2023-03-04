class ShowsController < ApplicationController
  before_action :set_show, only: %i[show edit update destroy add_to_calendar]
  before_action :search_params, only: %i[index]
  before_action :authenticate_user!, only: %i[add_to_calendar]
  before_action :token, only: %i[add_to_calendar]

  # GET /shows or /shows.json
  def index; end

  def search
    venue = params[:venue_input]
    if venue.present?
      @shows = ShowBuilderService.build_custom(SearchScraper.shows(venue))
      redirect_to root_path, notice: 'Shows found!'
    else
      redirect_to root_path notice: 'Please enter a venue'
    end
  end

  # GET /shows/1 or /shows/1.json
  def show; end

  # GET /shows/new
  def new
    @show = Show.new
  end

  # GET /shows/1/edit
  def edit; end

  # POST /shows or /shows.json
  def create
    @show = Show.new(show_params)

    respond_to do |format|
      if @show.save
        format.html { redirect_to show_url(@show), notice: 'Show was successfully created.' }
        format.json { render :show, status: :created, location: @show }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shows/1 or /shows/1.json
  def update
    respond_to do |format|
      if @show.update(show_params)
        format.html { redirect_to show_url(@show), notice: 'Show was successfully updated.' }
        format.json { render :show, status: :ok, location: @show }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shows/1 or /shows/1.json
  def destroy
    @show.destroy

    respond_to do |format|
      format.html { redirect_to shows_url, notice: 'Show was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_to_calendar
    response = CalendarClient.insert_event(current_user.access_token, @show)
    if response['status'] == 'confirmed'
      redirect_to root_path, notice: 'Show added to your calendar!'
    else
      redirect_to root_path, notice: 'Something went wrong. Please try again.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_show
    @show = Show.find(params[:id])
  end

  def search_params
    @shows = if params[:date_input].present?
               Show.search(params[:search], params[:date_input])
             else
               Show.search(params[:search])
             end
  end

  def show_params
    params.require(:show).permit(:band, :doors, :venue, :date)
  end

  def token
    return unless current_user.access_token_expired?

    current_user.refresh_access_token!
    current_user.save!
  end
end
