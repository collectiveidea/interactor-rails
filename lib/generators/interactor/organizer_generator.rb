require "generators/interactor"

module Interactor
  class OrganizerGenerator < Interactor::Generator
    argument :interactors, type: :array, default: [], banner: "name name"
  end
end
