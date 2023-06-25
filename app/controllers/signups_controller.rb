class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with:  :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response

    def index
        signups = Signup.all
        render json: signups, except: [:created_at, :updated_at], status: :ok
    end

    def show
        signup = finder
        render json: signup, except: [:created_at, :updated_at], include: [:camper, :activity],status: :ok
    end

    def create
        new_signup = Signup.create!(valid_params)
        render json: new_signup, except: [:created_at, :updated_at], status: :created
    end

    def update
        signup = finder
        signup.update!(valid_params)
        render json: signup, except: [:created_at, :updated_at], status: :accepted
    end

    def destroy
        signup = finder
        signup.destroy
        head :no_content
    end

    private
        def finder
            Signup.find(params[:id])
        end

        def valid_params
            params.permit(:camper_id, :activity_id, :time)
        end

        def not_found
            render json: {error: "Signup not found"}, status: :not_found
        end

        def unprocessable_entity_response(invalid)
            render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
        end
end
