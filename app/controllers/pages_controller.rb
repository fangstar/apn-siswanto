class PagesController < ApplicationController
  before_action :find_page, :only => [:show, :edit]
  before_action :new_page, :only => [:new, :create]
  load_and_authorize_resource
  def index
    @pages = Page.all
  end

  def show
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to page_path @page
    else
      render :new
    end
  end

  def edit
  end

  def update
    @page = Page.find(params[:id])
    @page.assign_attributes(page_params)
    if @page.save
      redirect_to page_path @page
    else
      render :edit
    end
  end

  private
  def new_page
    @page = Page.new(page_params)
  end
  def find_page
    @page = Page.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :body) if params[:page]
  end
end
