class ApidocsController < ApplicationController
  include Swagger::Blocks

  swagger_root do
    key :swaggerVersion, '1.2'
    key :apiVersion, '1.0.0'
    info do
      key :title, 'MatchTheCity App'
    end
    api do
      key :path, '/regions'
      key :description, 'Operations about regions'
    end
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
    RegionsController,
    Region,
    self,
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end

  def show
    render json: Swagger::Blocks.build_api_json(params[:id], SWAGGERED_CLASSES)
  end
end
