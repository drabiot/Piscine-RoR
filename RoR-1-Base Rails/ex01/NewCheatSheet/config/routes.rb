Rails.application.routes.draw do
	root "pages#convention"

	get 'console', to: 'pages#console'
	get 'ruby', to: 'pages#ruby'
	get 'ruby_concepts', to: 'pages#ruby-concepts'
	get 'ruby_numbers', to: 'pages#ruby-numbers'
	get 'ruby_strings', to: 'pages#ruby-strings'
	get 'ruby_arrays', to: 'pages#ruby-arrays'
	get 'ruby_hashes', to: 'pages#ruby-hashes'
	get 'rails_folder_structure', to: 'pages#rails-folder-structure'
	get 'rails_commands', to: 'pages#rails-commands'
	get 'rails_erb', to: 'pages#rails-erb'
	get 'editor', to: 'pages#editor'
	get 'help', to: 'pages#help'
end
