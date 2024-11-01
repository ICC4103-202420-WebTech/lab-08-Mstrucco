class TrainingSessionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_training_session, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:show, :edit, :update, :destroy]
  
    # GET /training_sessions
    def index
      @training_sessions = current_user.training_sessions.order(date: :desc)
    end
  
    # GET /training_sessions/:id
    def show
    end
  
    # GET /training_sessions/new
    def new
      @training_session = current_user.training_sessions.build
    end
  
    # POST /training_sessions
    def create
      @training_session = current_user.training_sessions.build(training_session_params)
      if @training_session.save
        redirect_to training_sessions_path, notice: 'Training session was successfully created.'
      else
        render :new
      end
    end
  
    # GET /training_sessions/:id/edit
    def edit
    end
  
    # PATCH/PUT /training_sessions/:id
    def update
      if @training_session.update(training_session_params)
        redirect_to training_session_path(@training_session), notice: 'Training session was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /training_sessions/:id
    def destroy
      @training_session.destroy
      redirect_to training_sessions_path, notice: 'Training session was successfully deleted.'
    end
  
    private
  
    def set_training_session
      @training_session = current_user.training_sessions.find_by(id: params[:id])
    end
  
    def authorize_user!
      redirect_to training_sessions_path, alert: 'Not authorized' if @training_session.nil?
    end
  
    def training_session_params
      params.require(:training_session).permit(:date, :activity, :duration, :description)
    end
  end
  