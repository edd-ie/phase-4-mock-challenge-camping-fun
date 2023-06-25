class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with:  :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response

    def index
        campers = Camper.all
        render json: campers, except: [:created_at, :updated_at], status: :ok
    end

    def show
        camper = finder
        render json: camper, except: [:created_at, :updated_at], include: :activities ,status: :ok
    end

    def create
        new_camper = Camper.create!(valid_params)
        render json: new_camper, except: [:created_at, :updated_at], status: :created
    end

    def update
        camper = finder
        camper.update!(valid_params)
        render json: camper, except: [:created_at, :updated_at], status: :accepted
    end

    def destroy
        camper = finder
        camper.destroy
        head :no_content
    end

    private
        def finder
            Camper.find(params[:id])
        end

        def valid_params
            params.permit(:name, :age)
        end

        def not_found
            render json: {error: "record not found"}, status: :not_found
        end

        def unprocessable_entity_response(invalid)
            render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
        end

end
