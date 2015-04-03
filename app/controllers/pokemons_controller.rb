class PokemonsController < ApplicationController
	def capture
		@pokemon_id = Pokemon.find(params[:id])
		@pokemon_id.update(trainer_id: current_trainer.id)
		@pokemon_id.save
		redirect_to root_url
	end

	def damage
		@pokemon_id = Pokemon.find(params[:id])
		@pokemon_id.health -= 10
		if @pokemon_id.health <= 0
			@pokemon_id.destroy
			redirect_to @pokemon_id.trainer
		else
			@pokemon_id.save
			redirect_to @pokemon_id.trainer
		end
	end

	def new
		@pokemon = Pokemon.new
	end

	def create
		@pokemon = Pokemon.new(pokemon_params)
		@pokemon.update(level: 1, health: 100, trainer_id: current_trainer.id)
		if @pokemon.save
			redirect_to current_trainer
		else
			redirect_to new_path
			flash[:error] = @pokemon.errors.full_messages.to_sentence
		end
	end

	def pokemon_params
		params.require(:pokemon).permit(:name)
	end
end
