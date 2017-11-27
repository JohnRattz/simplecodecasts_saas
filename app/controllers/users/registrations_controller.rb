class Users::RegistrationsController < Devise::RegistrationsController
	before_action :select_plan, only: :new

	def create
		super do |resource|
			if params[:plan]
				resource.plan_id = params[:plan]
				if resource.plan_id == 1
					resource.save
				else
					resource.save_with_payment
				end
			end
		end
	end

  private
	def select_plan
		unless params[:plan] && (params[:plan] == '1' || params[:plan] == '2')
			flash[:notice] = "Please select a membership plan to sign up."
			redirect_to root_path
		end
	end
end