module Clouds
  class LibrariesController < ApplicationController

    before_action :set_cloud

    def index
    end

    def new
      @library = @cloud.libraries.build
    end

    def create
      @library = @cloud.libraries.build(strong_params)
      if @library.save
        flash.now[:notice] = 'Successfully added library.'
        render 'index'
      else
        render 'new'
      end
    end

    def edit
      @library = @cloud.libraries.find(params[:id])
    end

    def update
      @library = @cloud.libraries.find(params[:id])
      if @library.update(strong_params)
        flash.now[:notice] = 'Successfully updated library.'
        render 'index'
      else
        render 'edit'
      end
    end

    def destroy
      @library = @cloud.libraries.find(params[:id])
      if @library.destroy
        flash.now[:notice] = 'Successfully deleted library.'
        render 'index'
      else
        flash.now[:alert] = 'Failed to delete library.'
        render 'index'
      end
    end

    private

    def strong_params
      params.require(:cloud_library).permit(:name, :url)
    end

  end
end
