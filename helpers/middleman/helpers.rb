require 'ostruct'

# Load these as they're prone to change.
load File::expand_path('./collection.rb', __dir__)
load File::expand_path('./locale.rb', __dir__)
load File::expand_path('./page.rb', __dir__)
load File::expand_path('./url.rb', __dir__)

module MiddlemanHelpers
  include ::MiddlemanCollectionHelpers
  include ::MiddlemanLocaleHelpers
  include ::MiddlemanPageHelpers
  include ::MiddlemanUrlHelpers
end
