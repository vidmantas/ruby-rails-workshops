require 'rho/rhocontroller'
require 'helpers/browser_helper'

class NoteController < Rho::RhoController
  include BrowserHelper

  # GET /Note
  def index
    #Alert.show_popup "Hello, Ruby"
    @notes = Note.find(:all)
    render :back => '/app'
  end

  # GET /Note/{1}
  def show
    @note = Note.find(@params['id'])
    if @note
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Note/new
  def new
    Camera::choose_picture(url_for(:action => :choose_callback))
    redirect :action => :index
    # @note = Note.new
    # render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Note/{1}/edit
  def edit
    @note = Note.find(@params['id'])
    if @note
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Note/create
  def create
    @note = Note.create(@params['note'])
    redirect :action => :index
  end

  # POST /Note/{1}/update
  def update
    @note = Note.find(@params['id'])
    @note.update_attributes(@params['note']) if @note
    redirect :action => :index
  end

  # POST /Note/{1}/delete
  def delete
    @note = Note.find(@params['id'])
    @note.destroy if @note
    redirect :action => :index  
  end

  def ringtones
    Rho::RingtoneManager.stop
    @ringtones = Rho::RingtoneManager.get_all_ringtones
    @ringtones = [] if @ringtones.nil?
    render :action => 'ringtones',:back => '/app'  
  end

  def choose_callback
    if @params['status'] == 'ok'
      note = Note.create({ 'title' => 'My best', 'image_uri' => @params['image_uri'] })
      WebView.navigate(url_for(:action => :edit, :id => note.object))
    else
      WebView.navigate(url_for(:action => :index))
    end
  end
end
