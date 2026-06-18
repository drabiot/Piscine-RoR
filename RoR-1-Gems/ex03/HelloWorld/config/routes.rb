#!/usr/bin/env -S ruby -w

Rails.application.routes.draw do
	root "pages#home"
end
