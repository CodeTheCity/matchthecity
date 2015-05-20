class ApidocsController < ApplicationController
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'MatchTheCity'
      key :description, "This is the MatchTheCity server."
      key :contact, 'andrew@xoverto.com'
    end
    #key :host, 'matchthecity.org'
    key :basePath, Rails.application.routes.url_helpers.root_path
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
    RegionsController,
    Region,
    VenueOwnersController,
    VenueOwner,
    VenuesController,
    Venue,
    OpportunitiesController,
    Opportunity,
    EffortRating,
    EffortRatingsController,
    self,
  ].freeze

  def index
  	render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end