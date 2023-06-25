class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with:  :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response

    def index
        activities = Activity.all
        render json: activities, except: [:created_at, :updated_at], status: :ok
    end

    def show
        activity = finder
        render json: activity, include: :campers ,status: :ok
    end

    def create
        new_activity = Activity.create!(valid_params)
        render json: new_activity, except: [:created_at, :updated_at], status: :created
    end

    def update
        activity = finder
        activity.update!(valid_params)
        render json: activity, except: [:created_at, :updated_at], status: :accepted
    end

    def destroy
        activity = finder
        activity.destroy
        head :no_content
    end

    private
        def finder
            Activity.find(params[:id])
        end

        def valid_params
            params.permit(:name, :difficulty)
        end

        def not_found
            render json: {error: "Activity not found"}, status: :not_found
        end

        def unprocessable_entity_response(invalid)
            render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
        end
end
