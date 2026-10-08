Rails.application.routes.draw do
	root "pages#convention"

	get 'console', to: 'pages#console'
	get 'ruby', to: 'pages#ruby'
	get 'ruby-concepts', to: 'pages#ruby-concepts'
	get 'ruby-numbers', to: 'pages#ruby-numbers'
	get 'ruby-strings', to: 'pages#ruby-strings'
	get 'ruby-arrays', to: 'pages#ruby-arrays'
	get 'ruby-hashes', to: 'pages#ruby-hashes'
	get 'rails', to: 'pages#rails'
	get 'rails-folder-structure', to: 'pages#rails-folder-structure'
	get 'rails-commands', to: 'pages#rails-commands'
	get 'rails-erb', to: 'pages#rails-erb'
	get 'editor', to: 'pages#editor'
	get 'help', to: 'pages#help'
	get 'quick-search', to: 'pages#quick-search'
	get 'log-book', to: 'pages#log-book'
end
